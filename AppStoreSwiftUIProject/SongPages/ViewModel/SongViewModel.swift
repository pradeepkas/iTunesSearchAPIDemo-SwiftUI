//
//  SongViewModel.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 19/7/23.
//

import Foundation
import Combine


class SongViewModel: ObservableObject {
    
    @Published var songList = [Songs]()
    @Published var currentState: APIState = .none

    @Published var searchTerm: String = ""

    var currentSearchTerm: String = "" {
        didSet {
            print("term == \(self.currentSearchTerm)")
            getSongs()
        }
    }
    
    var networkRequest: NetworkRequestProtocol
    private var cancellable = Set<AnyCancellable>()

    init(_ networkRequest: NetworkRequestProtocol = NetworkHandler()) {
        self.networkRequest = networkRequest
        
        $searchTerm
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .dropFirst()
            .sink { completion in
                print("completion")
            } receiveValue: { [weak self] term in
                if term.isEmpty {
                    self?.currentSearchTerm = ""
                    self?.songList = []
                } else {
                    self?.currentSearchTerm = term
                }
            }.store(in: &cancellable)
    }
    
    
    func getSongs() {
        if currentSearchTerm.isEmpty {return}
        currentState = .loading
        let request = AppStoreRequest.music(currentSearchTerm) // its is same as album for now later we have to put check
        networkRequest.getData(request, type: SongData.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self?.songList = []
                    self?.currentState = .error(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] albumData in
                self?.songList = albumData.results
                self?.currentState = .data
            }
            .store(in: &cancellable)
    }
    
    
    
    
    
}


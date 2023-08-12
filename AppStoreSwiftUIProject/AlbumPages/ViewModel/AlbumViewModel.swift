//
//  AlbumViewModel.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 17/7/23.
//

import Foundation
import Combine

//https://itunes.apple.com/search?term=jack+johnson&entity=album.

class AlbumViewModel: ObservableObject {
    
    @Published var albumList = [Album]()
    
    @Published var currentState: APIState = .none
        
    @Published var searchTerm: String = ""
    
    var currentSearchTerm: String = "" {
        didSet {
            print("term in vaiable == \(self.currentSearchTerm)")
            getAlbum()
        }
    }
    
    var networkRequest: NetworkRequestProtocol
    private var cancellable = Set<AnyCancellable>()

    init(_ networkRequest: NetworkRequestProtocol = NetworkHandler()) {
        self.networkRequest = networkRequest
        
        $currentState
            .sink { state in
                print("current state ==== \(state)")
            }
            .store(in: &cancellable)
                
        $searchTerm
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .dropFirst()
            .sink { completion in
                print("completion")
            } receiveValue: { [weak self] term in
                if term.isEmpty {
                    self?.currentSearchTerm = ""
                    self?.albumList = []
                } else {
                    self?.currentSearchTerm = term
                }
            }.store(in: &cancellable)
    }
    
    
    func getAlbum() {
        print("term in getalbum == \(currentSearchTerm)")
        if currentSearchTerm.isEmpty {
            self.albumList = []
            return
        }
        currentState = .loading
        let request = AppStoreRequest.album(currentSearchTerm)
        networkRequest.getData(request, type: AlbumData.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("error -- \(error.localizedDescription)")
                    self?.albumList = []
                    self?.currentState = .error(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] albumData in
                self?.currentState = .data
                self?.albumList = albumData.tracks
                print("data is there == \(albumData.tracks.count)")
            }
            .store(in: &cancellable)
    }
    
    
    func dropElements() -> [Album] {
        var newData = [Album]()
        if albumList.count > 15 {
            let data = albumList[...15]
            newData = data.map({$0})
        } else {
            newData = albumList
        }
        return newData
    }
    
    
}

extension Publisher  {
    
    
    
}

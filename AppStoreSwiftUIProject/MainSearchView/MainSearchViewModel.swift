//
//  AllViewModel.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 26/7/23.
//

import Foundation
import Combine

class MainSearchViewModel: ObservableObject {
    
    @Published var movieList = [Movies]()
    @Published var currentState: APIState = .none

    var searchTerm = PassthroughSubject<String, Never>()
    
    var networkRequest: NetworkRequestProtocol
    private var cancellable = Set<AnyCancellable>()

    init(_ networkRequest: NetworkRequestProtocol = NetworkHandler()) {
        self.networkRequest = networkRequest
        
        searchTerm
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .dropFirst()
            .sink { completion in
                print("completion")
            } receiveValue: { [weak self] term in
                //self?.getMovies(term)
            }.store(in: &cancellable)
    }
}


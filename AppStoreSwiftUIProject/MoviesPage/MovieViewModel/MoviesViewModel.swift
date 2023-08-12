//
//  MoviesViewModel.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 25/7/23.
//

import Foundation
import Combine


class MovieViewModel: ObservableObject {
    
    @Published var movieList = [Movies]()
    @Published var currentState: APIState = .none
    @Published var searchTerm: String = ""

    var currentSearchTerm: String = "" {
        didSet {
            getMovies()
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
                    self?.movieList = []
                } else {
                    self?.currentSearchTerm = term
                }
            }.store(in: &cancellable)
    }
    
    
    func getMovies() {
        print("term == \(currentSearchTerm)")
        if currentSearchTerm.isEmpty {
            self.movieList = []
            return
        }
        currentState = .loading
        let request = AppStoreRequest.movie(currentSearchTerm)
        networkRequest.getData(request, type: MovieData.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self?.movieList = []
                    self?.currentState = .error(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] moviesList in
                self?.movieList = moviesList.results
                self?.currentState = .data
            }
            .store(in: &cancellable)
    }
}


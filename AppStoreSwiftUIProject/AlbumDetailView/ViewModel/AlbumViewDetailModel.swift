//
//  AlbumViewDetailModel.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 9/8/23.
//

import Foundation
import Combine

class AlbumViewDetailModel: ObservableObject {
    
    @Published var songList = [Songs]()
    
    @Published var currentState: APIState = .none

    var networkRequest: NetworkRequestProtocol
    private var cancellable = Set<AnyCancellable>()

    init(_ networkRequest: NetworkRequestProtocol = NetworkHandler()) {
        self.networkRequest = networkRequest
        
    }
    
    func getAlbumSongs(_ albumCollectionId: Int) {
        currentState = .loading
        let request = AppStoreRequest.albumSong(albumCollectionId)
        networkRequest.getData(request, type: SongData.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("error -- \(error.localizedDescription)")
                    self?.songList = []
                    self?.currentState = .error(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] songsData in
                self?.currentState = .data
                self?.songList = []
                if songsData.results.count > 1 {
                    let songs = songsData.results.dropFirst()
                    self?.songList = songs.map({$0})
                }
                print("data is there == \(songsData.results.count)")
            }
            .store(in: &cancellable)
    }


    
}

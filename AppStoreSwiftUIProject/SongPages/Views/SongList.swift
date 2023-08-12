//
//  SongList.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 19/7/23.
//

import SwiftUI

struct SongList: View {
    
    @ObservedObject var viewModel = SongViewModel()
    @State var searchTerm = ""
    @State var id: Int = 0
    
    var body: some View {
        
        NavigationView {
            List {
                if viewModel.currentState == APIState.loading {
                    LoaderView(id: $id)
                }

                ForEach(viewModel.songList, id: \.id) { song in
                    Text(song.collectionName ?? "")
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchTerm)
            .task(id: searchTerm, {
                viewModel.currentSearchTerm = searchTerm
            })
            .navigationTitle("Song list")
        }
        
    }
}

struct SongList_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}

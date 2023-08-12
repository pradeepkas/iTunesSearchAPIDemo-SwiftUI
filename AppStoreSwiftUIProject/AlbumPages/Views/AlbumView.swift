//
//  AlbumView.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 26/7/23.
//

import SwiftUI

struct AlbumView: View {
    
    @StateObject var viewModel: AlbumViewModel
    @State var loaderId = 0

    var body: some View {
        List {
            
            switch viewModel.currentState {
            case .data:
                ForEach(viewModel.albumList, id: \.id) { album in
                    NavigationLink {
                        AlbumViewDetail(album: album)
                    } label: {
                        AlbumRow(album: album)
                    }
                }
            case .error(let error):
                Text(error.localizedDescription)
                    .font(.title2)
            case .loading:
                LoaderView(id: $loaderId)
            case .none:
                EmptyView()
            }
        }
        .onAppear(perform: {
            viewModel.getAlbum()
        })
        .listStyle(.plain)
    }
    
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(viewModel: AlbumViewModel())
    }
}

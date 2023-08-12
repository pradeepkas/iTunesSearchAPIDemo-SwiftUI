//
//  AllList.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 26/7/23.
//

import SwiftUI

struct MainSearchView: View {
    @State var selectedSeg: EntityType = .all
    @State var searchTerm: String = "swift"
    @State var loaderId: Int = 0
    
    @StateObject var albumVM = AlbumViewModel()
    @StateObject var movieVM = MovieViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("All Data", selection: $selectedSeg) {
                    ForEach(EntityType.allCases, id: \.self) { data in
                        Text(data.value).tag(data.id)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                Divider()
                if searchTerm.isEmpty {
                    TrendingViews(searchTerm: $searchTerm)
                        .frame(maxHeight: .infinity)
                } else {
                    switch selectedSeg {
                    case .all:
                        AllListView(viewModelAlbum: albumVM, viewModelMovie: movieVM)
                    case .movie:
                        MovieView(viewModel: movieVM)
                    case .album:
                        AlbumView(viewModel: albumVM)
                    }
                }
                Spacer()
            }
            .onChange(of: selectedSeg) { newValue in
                UpdateSearchTerm(searchTerm)
            }
            .onChange(of: searchTerm) { newValue in
                UpdateSearchTerm(newValue)
            }
            .onAppear(perform: {
                UpdateSearchTerm(searchTerm)
            })
            .searchable(text: $searchTerm)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    fileprivate func APICallsForSearchTerm() {
        switch selectedSeg {
        case .all:
            albumVM.getAlbum()
            movieVM.getMovies()
        case .album:
            albumVM.getAlbum()
        case .movie:
            movieVM.getMovies()
        }
    }
    
    fileprivate func UpdateSearchTerm(_ term: String) {
        switch selectedSeg {
        case .all:
            albumVM.currentSearchTerm = term
            movieVM.currentSearchTerm = term
        case .album:
            albumVM.currentSearchTerm = term
        case .movie:
            movieVM.currentSearchTerm = term
        }
    }
}

struct AllList_Previews: PreviewProvider {
    static var previews: some View {
        MainSearchView()
    }
}

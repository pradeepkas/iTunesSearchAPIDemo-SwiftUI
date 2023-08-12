//
//  MovieList.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 25/7/23.
//

import SwiftUI

struct MovieList: View {
    
    @StateObject var viewModel = MovieViewModel()
    @State var searchTerm = ""
    @State var id = 0
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.currentSearchTerm.isEmpty {
                    TrendingViews(searchTerm: $searchTerm)
                } else {
                    MovieView(viewModel: viewModel)
                }
            }
            .navigationTitle("Search Movies")
            .onChange(of: searchTerm, perform: { newValue in
                viewModel.searchTerm = newValue
            })
            .searchable(text: $searchTerm)
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}


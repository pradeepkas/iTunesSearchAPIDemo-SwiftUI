//
//  MovieView.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 5/8/23.
//

import SwiftUI

struct MovieView: View {
    @StateObject var viewModel: MovieViewModel
    @State var id = 0

    var body: some View {
        List {
            switch viewModel.currentState {
            case .data:
                ForEach(viewModel.movieList, id: \.id) { movie in
                    MovieRow(movie: movie)
                }
            case .error(let error):
                Text(error.localizedDescription)
                    .font(.title2)
            case .loading:
                LoaderView(id: $id)
            case .none:
                EmptyView()
            }
        }
        .onAppear(perform: {
            viewModel.getMovies()
        })
        .listStyle(.plain)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(viewModel: MovieViewModel())
    }
}

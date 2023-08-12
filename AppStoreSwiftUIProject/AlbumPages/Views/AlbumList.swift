//
//  AlbumList.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 17/7/23.
//

import SwiftUI

struct AlbumList: View {
    
    @StateObject var viewModel = AlbumViewModel()
    @State var searchTerm = ""
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.currentSearchTerm.isEmpty {
                    TrendingViews(searchTerm: $searchTerm)
                } else {
                    AlbumView(viewModel: viewModel)
                }
            }
            .navigationTitle("Search Album")
            .onChange(of: searchTerm, perform: { newValue in
                viewModel.searchTerm = newValue
            })
            .searchable(text: $searchTerm)
        }
    }
}

struct AlbumList_Previews: PreviewProvider {
    static var previews: some View {
        AlbumList()
    }
}


struct LoaderView: View {
    @Binding var id: Int
    
    var body: some View {
        HStack {
            Spacer()
            ProgressView("Loading...").progressViewStyle(.circular)
                .id(id)
                .onAppear {
                    id += 1
                }
            Spacer()
        }
    }
}



//NavigationView {
//    ZStack {
//        AlbumView(viewModel: viewModel)
//        if searchTerm.isEmpty {
//            TrendingViews(searchTerm: $searchTerm)
//                .frame(height: .infinity)
//        }
//    }
//    .searchable(text: $searchTerm)
//    .task(id: searchTerm, {
//        //viewModel.searchTerm.send(searchTerm)
//    })
//    .navigationTitle("Search Album")
//}

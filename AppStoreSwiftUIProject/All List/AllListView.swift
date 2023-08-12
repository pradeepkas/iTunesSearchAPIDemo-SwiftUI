//
//  AllListView.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 5/8/23.
//

import SwiftUI

struct AllListView: View {
    
    @StateObject var viewModelAlbum: AlbumViewModel
    @StateObject var viewModelMovie: MovieViewModel
    
    
    var body: some View {
        ScrollView {
            LazyVStack {
                HStack {
                    Text("Albums in Grid")
                    Spacer()
                    NavigationLink {
                        AlbumView(viewModel: viewModelAlbum)
                    } label: {
                        HStack {
                            Text("See All")
                            Image(systemName: "chevron.compact.right")
                        }
                    }
                }
                Divider()

                TopHeaderGridView(albums: viewModelAlbum.dropElements())
                                                                
                HStack {
                    Text("Movies")
                    Spacer()
                    NavigationLink {
                        MovieView(viewModel: viewModelMovie)
                    } label: {
                        HStack {
                            Text("See All")
                            Image(systemName: "chevron.compact.right")
                        }
                    }
                }
                
                Divider()
                MovieRowListHome(list: viewModelMovie.movieList)
                
                HStack {
                    Text("Albums")
                    Spacer()
                    NavigationLink {
                        AlbumView(viewModel: viewModelAlbum)
                    } label: {
                        HStack {
                            Text("See All")
                            Image(systemName: "chevron.compact.right")
                        }
                    }
                }
                Divider()
                RowForAlbumHome(list: viewModelAlbum.albumList)

                Spacer()
            }
            .padding(.all)
        }
    }
}

struct AllListView_Previews: PreviewProvider {
    static var previews: some View {
        AllListView(viewModelAlbum: Album.getStaticAlbum(), viewModelMovie: Movies.getStaticMovie())
    }
}


struct SectionView: View {
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    Text("Album")
                    Spacer()
                    Button {
                        print("clicked")
                    } label: {
                        Label("See All", systemImage: "arrow.right.to.line.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                .textCase(nil)
                .font(.callout)
            }
            Spacer(minLength: 10)
        }
    }
    
}

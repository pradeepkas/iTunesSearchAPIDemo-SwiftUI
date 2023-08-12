//
//  TopHeaderGridView.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 9/8/23.
//

import SwiftUI

struct TopHeaderGridView: View {
    
    var gridItem: [GridItem] = Array(repeating: GridItem(.fixed(60)), count: 4)
    
    var albums: [Album]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridItem, spacing: 20) {
                ForEach(albums, id: \.id) { album in
                    NavigationLink {
                        AlbumViewDetail(album: album)
                    } label: {
                        HStack(alignment: .center) {
                            ImageDownloading(url: album.artworkUrl100, size: CGSize(width: 50, height: 50))
                            VStack(alignment: .leading, spacing: 1) {
                                Text(album.collectionName)
                                    .font(.footnote)
                                    .lineLimit(1)
                                Text(album.artistName)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                            Spacer()
                            PurchaseButton(text: String(format: "%.2f", album.collectionPrice ?? 0))
                        }
                    }
                    .frame(width: 300)
                    .buttonStyle(.plain)
                    
                }
                
            }
            Spacer(minLength: 20)
        }
    }
    
}

struct TopHeaderGridView_Previews: PreviewProvider {
    static var previews: some View {
        TopHeaderGridView(albums: Album.getStaticAlbum().albumList)
    }
}

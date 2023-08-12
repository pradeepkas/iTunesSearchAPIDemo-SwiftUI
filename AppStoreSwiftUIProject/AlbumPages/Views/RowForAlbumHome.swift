//
//  RowForAlbumHome.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 9/8/23.
//

import SwiftUI

struct RowForAlbumHome: View {
    
    var list: [Album]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .center) {
                ForEach(list, id: \.id) { data in
                    NavigationLink {
                        AlbumViewDetail(album: data)
                    } label: {
                        VStack(alignment: .leading) {
                            ImageDownloading(url: data.artworkUrl100,
                                             size: CGSize(width: 110, height: 100))
                            Text(data.collectionName)
                                .lineLimit(2)
                                .font(.caption)
                            Text(data.artistName)
                                .lineLimit(1)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .frame(width: 120, height: 150)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct RowForAlbumHome_Previews: PreviewProvider {
    static var previews: some View {
        RowForAlbumHome(list: Album.getStaticAlbum().albumList)
    }
}

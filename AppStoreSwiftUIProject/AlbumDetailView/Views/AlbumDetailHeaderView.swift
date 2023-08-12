//
//  AlbumDetailHeaderView.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 12/8/23.
//

import SwiftUI

struct AlbumDetailHeaderView: View {
    
    var album: Album
    
    var body: some View {
        HStack(alignment: .bottom) {
            ImageDownloading(url: album.artworkUrl100, size: .init(width: 100, height: 100))
            VStack(alignment: .leading) {
                Text(album.collectionName)
                    .font(.footnote)
                    .foregroundColor(Color(.label))
                Text(album.artistName)
                    .padding(.bottom, 5)
                                
                Text("\(album.trackCount) Songs")
                Text(album.primaryGenreName)
                Text("Released: \(album.releaseDate.releaseDateStr())")
            }
            .font(.caption)
            .foregroundColor(.gray)
            .lineLimit(1)
            
            Spacer()
            PurchaseButton(text: String(format: "%.2f", album.collectionPrice ?? 0))
            
        }
        .padding([.bottom, .top], 15)
        .padding([.leading, .trailing], 10)
        .background(Color(.systemBackground).edgesIgnoringSafeArea(.top).shadow(radius: 5.0))
    }
}

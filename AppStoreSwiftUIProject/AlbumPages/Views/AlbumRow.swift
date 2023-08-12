//
//  AlbumRow.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 18/7/23.
//

import SwiftUI

struct PurchaseButton: View {
    
    var text: String
    
    var body: some View {
        Button {
            print("clicked")
        } label: {
            Text("\(text) $")
                .font(.footnote)
        }
        .foregroundColor(.blue)
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 6.0, style: .circular)
                .stroke(.blue, lineWidth: 1.0)
            )
    }
    
}

struct AlbumRow: View {
    
    var album: Album
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ImageDownloading(url: album.artworkUrl100, size: CGSize(width: 60, height: 60))
            VStack(alignment: .leading, spacing: 1) {
                Text(album.collectionName)
                    .font(.footnote)
                    .lineLimit(2)
                Text(album.artistName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            PurchaseButton(text: String(format: "%.2f", album.collectionPrice ?? 0))
        }
        .frame(maxWidth: .infinity)
    }
}

struct AlbumRow_Previews: PreviewProvider {
    static var previews: some View {
        AlbumRow(album: Album.getStaticAlbum().albumList[0])
    }
}



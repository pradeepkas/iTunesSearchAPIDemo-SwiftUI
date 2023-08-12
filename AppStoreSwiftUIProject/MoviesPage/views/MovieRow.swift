//
//  MovieRow.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 8/8/23.
//

import SwiftUI

struct MovieRow: View {
    
    var movie: Movies
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ImageDownloading(url: movie.artworkUrl100, size: CGSize(width: 70, height: 100))
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.trackName)
                    .font(.footnote)
                    .lineLimit(2)
                Text(movie.primaryGenreName ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(Movies.releaseDateStr(movie.releaseDate))
                    .font(.caption)
                    .foregroundColor(.black)

            }
            Spacer()
            Button {
                print("clicked")
            } label: {
                Text("\(String(format: "%.2f", movie.collectionPrice ?? 0)) $")
                    .font(.footnote)
            }
            .foregroundColor(.blue)
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 6.0, style: .circular)
                    .stroke(.blue, lineWidth: 1.0)
                )
        }
        .frame(maxWidth: .infinity)
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: Movies(wrapperType: "track", kind: "", id: 0, artistName: "Richard Marquand", trackName: "Star Wars: The Digital Movie Collection", trackCensoredName: "", trackViewURL: "", previewURL: "", artworkUrl30: "", artworkUrl60: "", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Video123/v4/9f/f9/e8/9ff9e804-f7f5-2a01-54a8-c476a5a884fa/pr_source.lsr/100x100bb.jpg", collectionPrice: 19.99, trackPrice: 0.0, trackRentalPrice: 0.0, collectionHDPrice: nil, trackHDPrice: nil, trackHDRentalPrice: nil, releaseDate: "1983-05-25T07:00:00Z", collectionExplicitness: nil, trackExplicitness: nil, trackTimeMillis: nil, country: nil, currency: nil, primaryGenreName: "Comedy", contentAdvisoryRating: nil, shortDescription: nil, longDescription: nil, artistID: nil, artistViewURL: nil))
    }
}

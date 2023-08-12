//
//  MovieRowListHome.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 9/8/23.
//

import SwiftUI

struct MovieRowListHome: View {
    var list: [Movies]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack() {
                ForEach(list, id: \.id) { data in
                    VStack(alignment: .leading) {
                        ImageDownloading(url: data.artworkUrl100,
                                         size: CGSize(width: 70, height: 100))
                        Text(data.trackName)
                            .lineLimit(2)
                            .font(.caption)
                        Text(data.artistName)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .frame(width: 80, height: 150)
                }
            }
        }
    }
    
}

struct MovieRowListHome_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowListHome(list: Movies.getStaticMovie().movieList)
    }
}

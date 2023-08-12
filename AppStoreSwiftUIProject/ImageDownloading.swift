//
//  ImageDownloading.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 7/8/23.
//

import SwiftUI

struct ImageDownloading: View {
    let url: String
    let size: CGSize
    //@State var id: Int = 0
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView().progressViewStyle(.circular)
            case .success(let image):
                image
                    .resizable()
                    .border(.gray)
            case .failure(_):
                Color.red
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: size.width, height: size.height)
    }
}

struct ImageDownloading_Previews: PreviewProvider {
    static var previews: some View {
        ImageDownloading(url: "", size: CGSize(width: 100, height: 100))
    }
}

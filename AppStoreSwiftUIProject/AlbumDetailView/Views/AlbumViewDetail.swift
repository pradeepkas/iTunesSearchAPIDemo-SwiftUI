//
//  AlbumViewDetail.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 9/8/23.
//

import SwiftUI

struct AlbumViewDetail: View {
    
    var album: Album
    @StateObject var viewModel = AlbumViewDetailModel()
    
    var body: some View {
        
        VStack {
            
            AlbumDetailHeaderView(album: album)
            
            ScrollView(showsIndicators: false) {
                
                ForEach(viewModel.songList, id: \.id) { song in
                    HStack {
                        Text("\(song.trackNumber ?? 0)")
                            .font(.footnote)
                            .frame(width: 25, alignment: .trailing)
                        
                        Text("\(song.trackName ?? "")")
                            .font(.callout)
                        Spacer()
                        
                        Text(formatDuration(song.trackTimeMillis))
                            .font(.footnote)
                            .frame(width: 50)
                        
                        PurchaseButton(text: String(format: "%.2f", song.trackPrice ?? 0))
                        
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .onAppear {
            viewModel.getAlbumSongs(1027561834)
        }
        
    }
    
    
    func formatDuration(_ time: Int?) -> String {
        guard var time = time else {return ""}
        time = time / 1000
        
        let interval = TimeInterval(time)
        let fomatter = DateComponentsFormatter()
        
        return fomatter.string(from: interval) ?? ""
        
    }
}

struct AlbumViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        AlbumViewDetail(album: Album.getStaticAlbum().albumList[0])
    }
}

//
//  ContentView.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 17/7/23.
//

import SwiftUI

struct ContentView: View {
    @State var currentSelected: Int = 2
    var body: some View {
        TabView(selection: $currentSelected) {

            MainSearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            .background(Color.clear)

            AlbumList().tabItem {
                Label("Albums", systemImage: "play.rectangle.fill")
            }

            MovieList().tabItem {
                Label("Movie", systemImage: "video.circle.fill")
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            let defautlApperance = UITabBarAppearance()
            defautlApperance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = defautlApperance
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

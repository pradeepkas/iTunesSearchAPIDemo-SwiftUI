//
//  TrendingView.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 5/8/23.
//

import SwiftUI

struct TrendingViews: View {
    @Binding var searchTerm: String
    let trendingList = ["Cry", "John"]
    var body: some View {
        VStack(spacing: 10) {
            Text("Treding Data")
                .font(.title2)
            ForEach(trendingList, id: \.self) { data in
                Button(data) {
                    print("done")
                    searchTerm = data
                }
                .padding(.all, 5)
                .font(.title3)
            }
        }
    }
}

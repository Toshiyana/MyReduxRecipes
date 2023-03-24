//
//  RootView.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/20.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeContainerView()
            }
            .tabItem {
                Label("Menu", systemImage: "list.dash")
            }

            NavigationStack {
                FavoritesContainerView()
            }
            .tabItem {
                Label("Favorites", systemImage: "heart")
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

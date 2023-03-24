//
//  FavoritesContainerView.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import SwiftUI

struct FavoritesContainerView: View {
    @EnvironmentObject var store: AppStore

    private var favorites: [Recipe] {
        store.state.favorited.compactMap { uri in
            store.state.allRecipes[uri]
        }
    }
    var body: some View {
        if favorites.isEmpty {
            Text("Favorites is Empty")
        } else {
            RecipesView(recipes: favorites)
                .navigationTitle(Text("favorites"))
        }
    }
}

struct FavoritesContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesContainerView()
    }
}

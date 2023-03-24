//
//  RecipeDetailsContainerView.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import SwiftUI

struct RecipeDetailsContainerView: View {
    @EnvironmentObject var store: AppStore

    private let uri: String

    private var recipe: Recipe? {
        store.state.allRecipes[uri]
    }

    private var isFavorited: Bool {
        guard let uri = recipe?.uri else {
            return false
        }
        return store.state.favorited.contains(uri)
    }

    var body: some View {
        if let recipe {
            RecipeDetailsView(recipe: recipe)
                .navigationTitle(Text(recipe.title))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if isFavorited {
                                store.send(.removeFromFavorites(recipe: recipe))
                            } else {
                                store.send(.saveToFavorites(recipe: recipe))
                            }
                        } label: {
                            Image(systemName: isFavorited ? "heart.fill" : "heart")
                                .font(.headline)
                                .accessibility(label: Text(isFavorited ? "removeFromFavorites" : "addToFavorites"))
                        }
                    }
                }
        } else {
            Text("Recipe is null")
        }
    }

    init(uri: String) {
        self.uri = uri
    }
}

struct RecipeDetailsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsContainerView(uri: Recipe.mock.uri)
    }
}

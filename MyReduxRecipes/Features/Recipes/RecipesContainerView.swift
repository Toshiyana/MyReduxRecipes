//
//  RecipesContainerView.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import SwiftUI

struct RecipesContainerView: View {
    @EnvironmentObject var store: AppStore
    let query: String

    private var recipes: [Recipe] {
        store.state.recipes.compactMap { uri in
            store.state.allRecipes[uri]
        }
    }

    var body: some View {
        RecipesView(recipes: recipes)
            .navigationBarTitle(Text(query.capitalized), displayMode: .inline)
            .onAppear {
                store.send(.search(query: query))
            }
    }
}

struct RecipesContainerView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesContainerView(query: "")
    }
}

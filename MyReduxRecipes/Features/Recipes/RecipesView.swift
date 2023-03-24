//
//  RecipesView.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import SwiftUI
import Kingfisher

struct RecipesView: View {
    // 表示だけでStateを更新するActionはないので、Storeを定義する必要ない
    private let recipes: [Recipe]

    private var content: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(recipes, id: \.self) { recipe in
                    NavigationLink {
                        RecipeDetailsContainerView(uri: recipe.uri)
                    } label: {
                        ZStack(alignment: .bottomLeading) {
                            KFImage(recipe.imageUrl)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)

                            LinearGradient(
                                gradient: .init(colors: [Color.clear, Color.black.opacity(0.7)]),
                                startPoint: .center,
                                endPoint: .bottom
                            )

                            Text(recipe.title)
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                        }
                    }

                }
            }
        }
    }

    var body: some View {
        Group {
            if recipes.isEmpty {
                ActivityView()
            } else {
                content
            }
        }
    }

    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView(recipes: [.mock, .mock, .mock, .mock])
    }
}

//
//  RecipeDetailsView.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import SwiftUI
import Kingfisher

struct RecipeDetailsView: View {
    private let recipe: Recipe

    private var subheadline: some View {
        Text("\(Int(recipe.calories)) kcal ") +
        Text("\(Int(recipe.totalWeight)) g")
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(recipe.imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()

                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading) {
                        Text(recipe.title)
                            .font(.title)
                            .fixedSize(horizontal: false, vertical: true)

                        subheadline
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    ForEach(recipe.ingredients, id: \.self) { ingridient in
                        Text("● \(ingridient)")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    init(recipe: Recipe) {
        self.recipe = recipe
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(recipe: .mock)
    }
}

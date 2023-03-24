//
//  Recipe.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/21.
//

import Foundation

struct Recipe: Decodable, Hashable {
    let uri: String
    let title: String
    let ingredients: [String]
    let imageUrl: URL
    let calories: Double
    let totalWeight: Double
    let shareAs: URL
    let url: String
    let cautions: [String]

    enum CodingKeys: String, CodingKey {
        case uri
        case title = "label"
        case ingredients = "ingredientLines"
        case imageUrl = "image"
        case calories
        case totalWeight
        case shareAs
        case cautions
        case url
    }
}

extension Recipe {
    static let mock = Recipe(
        uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_ad1c8d4088d41ffbcf0715a5fa9b9572",
        title: "Breakfast",
        ingredients: ["123", "123", "123"],
        imageUrl: URL(string: "https://www.edamam.com/web-img/70a/70aaa8022bf8706c375551c44718eaab.jpg")!,
        calories: 10,
        totalWeight: 10,
        shareAs: URL(string: "http://www.seriouseats.com/recipes/2008/03/sack-lunch-fairytale-picnic-fresh-pickled-vegetables-recipe.html")!,
        url: "http://www.seriouseats.com/recipes/2008/03/sack-lunch-fairytale-picnic-fresh-pickled-vegetables-recipe.html",
        cautions: []
    )
}

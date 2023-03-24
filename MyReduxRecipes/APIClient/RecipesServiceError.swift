//
//  RecipesServiceError.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import Foundation

enum RecipesServiceError: Error {
    case invalidURL
    case url(error: URLError)
    case decoder(error: Error)
}

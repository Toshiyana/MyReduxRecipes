//
//  RecipesServiceProtocol.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import Combine

protocol RecipesServiceProtocol {
    func fetch(matching query: String, in diet: Health, page: Int) -> AnyPublisher<[Recipe], RecipesServiceError>
}

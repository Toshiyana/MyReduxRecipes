//
//  RecipesService.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import Foundation
import Combine

struct Hit: Decodable {
    let recipe: Recipe
}

struct RecipesService: RecipesServiceProtocol {
    private enum RecipeServiceConstants {
        static let count = 100
    }

    private struct RecipesResponse: Decodable {
        let hits: [Hit]
    }

    let session: URLSession
    let decoder: JSONDecoder

    func fetch(matching query: String, in diet: Health, page: Int) -> AnyPublisher<[Recipe], RecipesServiceError> {
        let from = page * RecipeServiceConstants.count
        let to = from + RecipeServiceConstants.count

        var components = URLComponents()

        components.scheme = "https"
        components.host = "api.edamam.com"
        components.path = "/search"

        components.queryItems = [
            .init(name: "q", value: query),
            .init(name: "from", value: String(from)),
            .init(name: "to", value: String(to)),
            .init(name: "app_id", value: "af1dd513"),
            .init(name: "app_key", value: "14d7fdc54649351cd3531103e09fc830"),
            .init(name: "health", value: diet.rawValue)
        ]

        guard let url = components.url else {
            return Fail<[Recipe], RecipesServiceError>(error: .invalidURL)
                .eraseToAnyPublisher()
        }

        return session
            .dataTaskPublisher(for: URLRequest(url: url))
            .mapError { RecipesServiceError.url(error: $0) }
            .map { $0.data }
            .decode(type: RecipesResponse.self, decoder: decoder)
            .mapError { RecipesServiceError.decoder(error: $0) }
            .map { $0.hits.map { $0.recipe } }
            .eraseToAnyPublisher()
    }
}

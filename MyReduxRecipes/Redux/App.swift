//
//  App.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/21.
//

import Combine
import Foundation

// Storeのデータをキャッシュとして保存する際に利用するものを定義
struct AppEnvironment {
    let recipesService = RecipesService(session: .shared, decoder: JSONDecoder())
}

// 状態
struct AppState {
    var allRecipes: [String: Recipe] = [:]
    var recipes: [String] = []
    var favorited: [String] = []
    var health: Health = .gluten
    var currentQuery = "" // 検索のクエリ
}

// Stateを更新するためのAction
enum AppAction {
    case setHealth(health: Health)
    case append(recipes: [Recipe])
    case search(query: String, page: Int = 0)
    case saveToFavorites(recipe: Recipe)
    case removeFromFavorites(recipe: Recipe)
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
    switch action {
    case let .setHealth(health):
        state.health = health
        state.recipes.removeAll()
        state.currentQuery = ""
    case let .append(recipes):
        recipes.forEach { state.allRecipes[$0.uri] = $0 }
        state.recipes = recipes.map { $0.uri }
    case let .search(query, page):
        guard state.currentQuery != query else {
            return Empty().eraseToAnyPublisher()
        }

        state.recipes.removeAll()
        state.currentQuery = query

        return environment.recipesService
            .fetch(matching: state.currentQuery, in: state.health, page: page)
            .replaceError(with: [])
            .map { .append(recipes: $0) }
            .eraseToAnyPublisher()
    case let .saveToFavorites(recipe):
        state.favorited.append(recipe.uri)
    case let .removeFromFavorites(recipe):
        state.favorited.removeAll { $0 == recipe.uri }
    }
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction>

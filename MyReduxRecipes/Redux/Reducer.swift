//
//  Reducer.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/22.
//

import Foundation
import Combine

struct Reducer<State, Action, Environment> {
    let reduce: (inout State, Action, Environment) -> AnyPublisher<Action, Never>

    func callAsFunction(
        _ state: inout State,
        _ action: Action,
        _ environment: Environment
    ) -> AnyPublisher<Action, Never> {
        reduce(&state, action, environment)
    }
}

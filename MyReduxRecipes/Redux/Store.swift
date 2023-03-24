//
//  Store.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/21.
//

import SwiftUI
import Combine

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State

    private let reduce: (inout State, Action) -> AnyPublisher<Action, Never>
    private let queue: DispatchQueue
    private var effectCancellables: [UUID: AnyCancellable] = [:]

    init<Environment>(
        initialState: State,
        reducer: Reducer<State, Action, Environment>,
        environment: Environment,
        subscriptionQueue: DispatchQueue = .init(label: "com.Toshiyana.store")
    ) {
        self.state = initialState
        self.reduce = { state, action in
            reducer(&state, action, environment)
        }
        self.queue = subscriptionQueue
    }

    func send(_ action: Action) {
        let effect = reduce(&state, action)

        var didComplete = false
        let uuid = UUID()

        let cancellable = effect
            .subscribe(on: queue) // 理解できていない
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    didComplete = true
                    self?.effectCancellables[uuid] = nil
                },
                receiveValue: { [weak self] action in
                    self?.send(action)
                }
            )

        if !didComplete {
            effectCancellables[uuid] = cancellable
        }
    }
}

extension Store {
    // StoreのStateを更新するためにActionと結びつける
    func binding<Value>(
        for keyPath: KeyPath<State, Value>,
        toAction: @escaping (Value) -> Action
    ) -> Binding<Value> {
        Binding<Value>(
            get: { self.state[keyPath: keyPath] },
            set: { self.send(toAction($0)) }
        )
    }
}

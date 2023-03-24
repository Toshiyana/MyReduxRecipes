//
//  MyReduxRecipesApp.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/20.
//

import SwiftUI

@main
struct MyReduxRecipesApp: App {
    private var store = AppStore(
        initialState: AppState(),
        reducer: appReducer,
        environment: AppEnvironment()
    )
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
    }
}

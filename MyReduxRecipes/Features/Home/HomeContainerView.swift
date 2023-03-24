//
//  HomeContainerView.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/20.
//

import SwiftUI

struct HomeContainerView: View {
    @EnvironmentObject var store: AppStore
    @State private var favoriteShown = false

    private var hasFavorites: Bool {
        !store.state.favorited.isEmpty
    }

    private var health: Binding<Health> {
        // StoreのStateを更新するためにActionと結びつける
        store.binding(for: \.health, toAction: { .setHealth(health: $0)} )
    }

    var body: some View {
        HomeView(health: health)
            .navigationTitle(Text("recipes"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    hasFavorites ?
                    Button(action: { favoriteShown = true }, label: {
                        Image(systemName: "heart.fill")
                            .font(.headline)
                            .accessibility(label: Text("favorites"))
                    }) : nil
                }
            }
            .sheet(isPresented: $favoriteShown) {
                NavigationStack {
                    FavoritesContainerView()
                }
            }
    }
}

struct HomeContainerView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContainerView()
    }
}

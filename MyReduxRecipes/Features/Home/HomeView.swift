//
//  HomeView.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import SwiftUI

struct CategoryView: View {
    let category: Category

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(category.query)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)

            LinearGradient(
                gradient: .init(colors: [Color.clear, Color.black.opacity(0.7)]),
                startPoint: .center,
                endPoint: .bottom
            )

            Text(LocalizedStringKey(category.title))
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct HomeView: View {
    @Binding var health: Health

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Picker(selection: $health) {
                    ForEach(Health.allCases, id: \.self) { health in
                        Text(LocalizedStringKey(health.rawValue)).tag(health)
                    }
                } label: {
                    Text("health")
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                ForEach(0..<Home.categories.count, id: \.self) { index in
                    NavigationLink {
                        RecipesContainerView(query: Home.categories[index].query)
                    } label: {
                        CategoryView(category: Home.categories[index])
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(health: .constant(.gluten))
    }
}

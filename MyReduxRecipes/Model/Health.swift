//
//  Health.swift
//  MyReduxRecipes
//
//  Created by 柳元 俊輝 on 2023/03/23.
//

import Foundation

enum Health: String, CaseIterable, Codable {
    case vegan
    case vegetarian
    case gluten = "gluten-free"
    case keto = "keto-friendly"
}

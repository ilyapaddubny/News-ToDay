//
//  User.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 30.03.2024.
//

import Foundation

struct User: Codable, Equatable {
    let name, email, password: String
    var fafouriteCategories: [Category]
    var tagCategory: Category?
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.email == rhs.email
    }
}

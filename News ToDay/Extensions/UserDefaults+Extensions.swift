//
//  UserDefaults+Extensions.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 26.03.2024.
//

import Foundation

extension UserDefaults {
    func categories(forKey key: String) -> [Category] {
        if let jsonData = data(forKey: key),
           let decodedCategories = try? JSONDecoder().decode([Category].self, from: jsonData) {
            return decodedCategories
        } else {
            return []
        }
    }
    
    func setValue(_ categories: [Category], forKey key: String) {
        if categories.isEmpty {
            removeObject(forKey: key)
        } else {
            if let encodedData = try? JSONEncoder().encode(categories){
                set(encodedData, forKey: key)
            }
            
        }
    }
    
    func category(forKey key: String) -> Category? {
        if let jsonData = data(forKey: key),
           let decodedCategories = try? JSONDecoder().decode(Category.self, from: jsonData) {
            return decodedCategories
        } else {
            return nil
        }
    }
    
    func setValue(_ category: Category, forKey key: String) {
        if let encodedData = try? JSONEncoder().encode(category){
            set(encodedData, forKey: key)
        }
    }
    
    
    //one user
    func user(forKey key: String) -> User? {
        if let jsonData = data(forKey: key),
           let user = try? JSONDecoder().decode(User.self, from: jsonData) {
            return user
        } else {
            return nil
        }
    }
    
    func setValue(_ user: User, forKey key: String) {
        if let encodedData = try? JSONEncoder().encode(user){
            set(encodedData, forKey: key)
        }
    }
    
    //array of users
    func users(forKey key: String) -> [User]? {
        if let jsonData = data(forKey: key),
           let users = try? JSONDecoder().decode([User].self, from: jsonData) {
            return users
        } else {
            return nil
        }
    }
    
    func setValue(_ users: [User], forKey key: String) {
        if let encodedData = try? JSONEncoder().encode(users){
            set(encodedData, forKey: key)
        }
    }
}

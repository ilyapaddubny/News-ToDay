//
//  Category.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 19.03.2024.
//

import Foundation

enum Category: String, Hashable, CaseIterable, Codable {
    case general = "general"
    case business = "business"
    case sports = "sports"
    case entertainment = "entertainment"
    case science = "science"
    case health = "health"
    case technology = "technology"
    
    
    // MARK: - Bookmark categories logic
    var isBookmarked: Bool {
        get {
//            var users = UserDefaults.standard.users(forKey: UserDefaultsConstants.listOfUsers)
            let currentUser = UserDefaults.standard.user(forKey: UserDefaultsConstants.userLoggedIn)
            print(currentUser)
            let categories = currentUser?.fafouriteCategories ?? []
            print(categories)
            return categories.contains(self)
        }
        
        set {
            guard var users = UserDefaults.standard.users(forKey: UserDefaultsConstants.listOfUsers)  else {return}
            guard var currentUser = UserDefaults.standard.user(forKey: UserDefaultsConstants.userLoggedIn) else {return}
            var categories = currentUser.fafouriteCategories
            if categories.contains(self), !newValue {
                categories.removeAll(where: {$0 == self})
            }
            // если мы добавляем кейс в избранное, нужно его добавить в массив
            if newValue {
                categories.append(self)
            }
            currentUser.fafouriteCategories = categories
            
            if let index = users.firstIndex(where: { $0 == currentUser }) {
                // Update the user in the users array
                users[index] = currentUser
                
                // Update the list of users in UserDefaults
                UserDefaults.standard.setValue(users, forKey: UserDefaultsConstants.listOfUsers)
                UserDefaults.standard.setValue(currentUser, forKey: UserDefaultsConstants.userLoggedIn)
            }
        }
    }
    
    // MARK: - Tag Section Logic
    var isSelectedOnTheMainScreen: Bool {
        get {
            guard let selectedCategory = UserDefaults.standard.category(forKey: UserDefaultsConstants.mainScreenCategoriesSelectedKey) else {return false}
            return self == selectedCategory
        }

        set {
            UserDefaults.standard.setValue(self, forKey:  UserDefaultsConstants.mainScreenCategoriesSelectedKey)
        }
    }
    
    
    func getButtonName() -> String {
        switch self {
        case .general:
            return CategoryStrings.general
        case .business:
            return CategoryStrings.business
        case .sports:
            return CategoryStrings.sports
        case .entertainment:
            return CategoryStrings.entertainment
        case .science:
            return CategoryStrings.science
        case .health:
            return CategoryStrings.health
        case .technology:
            return CategoryStrings.technology
        }
        }
    
    func getNamePlusIconString() -> String {
        switch self {
        case .general:
            return CategoryStringsWithEmoji.general
        case .business:
            return CategoryStringsWithEmoji.business
        case .sports:
            return CategoryStringsWithEmoji.sports
        case .entertainment:
            return CategoryStringsWithEmoji.entertainment
        case .science:
            return CategoryStringsWithEmoji.science
        case .health:
            return CategoryStringsWithEmoji.health
        case .technology:
            return CategoryStringsWithEmoji.technology
        }
    }
    
    
    
    static var categories: [Category] {
        return Array(self.allCases)
    }
    
    static var categoriesSortedABC: [Category] {
        return Array(self.allCases).sorted { $0.getButtonName() < $1.getButtonName() }
    }
}




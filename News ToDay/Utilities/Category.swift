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
            let categories = UserDefaults.standard.categories(forKey: UserDefaultsConstants.bookmarkedCategoriesKey)
            return categories.contains(self)
        }
        
        set {
            var categories = UserDefaults.standard.categories(forKey: UserDefaultsConstants.bookmarkedCategoriesKey)
            // если мы убираем кейс из избранного, нужно удалить его из массива
            if categories.contains(self), !newValue {
                categories.removeAll(where: {$0 == self})
            }
            // если мы добавляем кейс в избранное, нужно его добавить в массив
            if newValue {
                categories.append(self)
            }
            UserDefaults.standard.setValue(categories, forKey:  UserDefaultsConstants.bookmarkedCategoriesKey)
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




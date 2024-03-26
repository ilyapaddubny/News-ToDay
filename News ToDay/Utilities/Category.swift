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
            let categories = UserDefaults.standard.categories(forKey: UserDefaultsConstants.mainScreenCategoriesSelectedKey)
            return categories.contains(self)
        }

        set {
            var categories = UserDefaults.standard.categories(forKey: UserDefaultsConstants.mainScreenCategoriesSelectedKey)
            // если мы убираем кейс из избранного, нужно удалить его из массива
            if categories.contains(self), !newValue {
                categories.removeAll(where: {$0 == self})
            }
            // если мы добавляем кейс в избранное, нужно его добавить в массив
            if newValue {
                categories.append(self)
            }
            
            UserDefaults.standard.setValue(categories, forKey:  UserDefaultsConstants.mainScreenCategoriesSelectedKey)
        }
    }
    
    
    func getButtonName() -> String {
            switch self {
            case .general:
                return "General"
            case .business:
                return "Business"
            case .sports:
                return "Sports"
            case .entertainment:
                return "Leisure"
            case .science:
                return "Science"
            case .health:
                return " Health "
            case .technology:
                return "Digital"
            }
        }
    
    func getNamePlusIconString() -> String {
        switch self {
        case .general:
            return "🌐  General"
        case .business:
            return "💼  Business"
        case .sports:
            return "⚽️  Sports"
        case .entertainment:
            return "🎉  Leisure"
        case .science:
            return "🔬  Science"
        case .health:
            return "💊  Health"
        case .technology:
            return "📱  Digital"
        }
    }
    
    
    
    static var categories: [Category] {
        return Array(self.allCases)
    }
    
    static var categoriesSortedABC: [Category] {
        return Array(self.allCases).sorted { $0.getButtonName() < $1.getButtonName() }
    }
}




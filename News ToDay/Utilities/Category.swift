//
//  Category.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 19.03.2024.
//

import Foundation

enum Category: String, Hashable, CaseIterable {
    case general = "general"
    case business = "business"
    case sports = "sports"
    case entertainment = "entertainment"
    case science = "science"
    case health = "health"
    case technology = "technology"
    
    // MARK: - Categories bookmark logic
    static var bookmarked = [Category.business, Category.sports] //условно находится в памяти девайса
    
    var isBookmarked: Bool {
        
        // надо получать из кор-даты массив типа [Category] и возвращать значение [Category].contains(self)
        get {
            //TODO: (Для Миши) Category.bookmarked получать из core-data
            return Category.bookmarked.contains(self)
        }
        
        //TODO: (Для Миши) Category.bookmarked получать и записывать в core-data
        set {
            // если мы убираем кейс из избранного, нужно удалить его из массива
            if Category.bookmarked.contains(self), !newValue {
                Category.bookmarked.removeAll(where: {$0 == self})
            }
            // если мы добавляем кейс в избранное, нужно его добавить в массив
            if newValue {
                Category.bookmarked.append(self)
            }
        }
    }
    
    // MARK: - Tag Section Logic
    static var selectedOnTheMainScreen = [Category.general, Category.sports] //условно находится в памяти девайса
    
    var isSelectedOnTheMainScreen: Bool {
        
        // надо получать из кор-даты массив типа [Category] и возвращать значение [Category].contains(self)
        get {
            //TODO: (Для Миши) Category.bookmarked получать из core-data
            return Category.selectedOnTheMainScreen.contains(self)
        }
        
        //TODO: (Для Миши) Category.bookmarked получать и записывать в core-data
        set {
            // если мы убираем кейс из избранного, нужно удалить его из массива
            if Category.selectedOnTheMainScreen.contains(self), !newValue {
                Category.selectedOnTheMainScreen.removeAll(where: {$0 == self})
            }
            // если мы добавляем кейс в избранное, нужно его добавить в массив
            if newValue {
                Category.selectedOnTheMainScreen.append(self)
            }
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




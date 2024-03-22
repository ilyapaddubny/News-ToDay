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
    
    static var categories: [Category] {
        return Array(self.allCases)
    }
}




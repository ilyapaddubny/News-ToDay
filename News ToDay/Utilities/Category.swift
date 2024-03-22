//
//  Category.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 19.03.2024.
//

import Foundation

enum Category: String, Hashable, CaseIterable {
    case general = "General"
    case business = "Business"
    case sports = "Sports"
    case entertainment = "Leisure"
    case science = "Science"
    case health = " Health "
    case technology = "Digital"
    
    
    
    func toString() -> String {
        return self.rawValue
    }
    
    static var categories: [Category] {
        return Array(self.allCases)
    }
}



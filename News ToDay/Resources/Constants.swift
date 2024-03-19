//
//  Constants.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.
//

import UIKit

enum TabBarImage {
    static let home = UIImage(named: "TabBarHomeIcon")
    static let categories = UIImage(named: "TabBarCategoriesIcon")
    static let bookmarks = UIImage(named: "TabBarBookmarkIcon")
    static let user = UIImage(named: "TabBarProfileIcon")
}


enum TabBarSelectedImage {
    static let home = UIImage(named: "TabBarHomeSelectedIcon")
    static let categories = UIImage(named: "TabBarCategoriesSelectedIcon 1")
    static let bookmarks = UIImage(named: "TabBarBookmarkSelectedIcon")
    static let user = UIImage(named: "TabBarProfileSelectedIcon")
}


enum ScreenTitle {
    static let home = "Browse"
    static let categories = "Categories"
    static let bookmarks = "Bookmarks"
    static let user = "Profile"
}


enum Key {
    static let apiKey = "ddbae45c2e33483d9cec5e18eaa5a82c"
}


enum httpHeaderField {
    static let xApiKey = "X-Api-Key"
}

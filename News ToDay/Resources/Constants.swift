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

enum Icons {
    static let bookmarkStroke = UIImage(named: "BookmarkWhiteIcon")
    static let bookmarkFilled = UIImage(named: "BookmarkFilledWhiteIcon2")
    static let search = UIImage(named: "SearchIcon")
}


enum Image {
    static let placeholder = UIImage(named: "placeholder-image")
    static let arrowBackWhite = UIImage(named: "BackWhiteIcon")
    static let bookmarkWhite = UIImage(named: "BookmarkWhiteIcon")
    static let shareArrow = UIImage(named: "ForwardWhiteIcon")
    static let searchIcon = UIImage(named: "searchIcon")
}


enum ScreenTitle {
    static let home = "Browse"
    static let categories = "Categories"
    static let bookmarks = "Bookmarks"
    static let user = "Profile"
}


enum Subtitle {
    static let categories = "Thousands of articles in each category"
    static let browse = "Discover things of the world"
}


enum Placeholder {
    static let search = "Search"
}

enum EmptyListHelper {
    static let noBookmarks = "You haven't saved any articles yet. Start reading and bookmarking them now."
}


enum Key {
    static let apiKey = "ddbae45c2e33483d9cec5e18eaa5a82c"
}


enum httpHeaderField {
    static let xApiKey = "X-Api-Key"
}


enum Font {
    static func interRegular(with size: CGFloat) -> UIFont {
        UIFont(name: "Inter-Regular", size: size) ?? UIFont()
    }
    
    static func interSemiBold(with size: CGFloat) -> UIFont {
        UIFont(name: "Inter-SemiBold", size: size) ?? UIFont()
    }
    
    static func interBold(with size: CGFloat) -> UIFont {
        UIFont(name: "Inter-Bold", size: size) ?? UIFont()
    }
}

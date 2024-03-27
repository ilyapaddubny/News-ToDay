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
    static let emptyBookmarksIcon = UIImage(named: "EmptyBookmarksIcon")
}


enum ScreenTitle {
    static let home = NSLocalizedString("Browse", value: "Browse", comment: "Screen title: Browse")
    static let categories = NSLocalizedString("Categories", value: "Categories", comment: "Screen title: Categories")
    static let bookmarks = NSLocalizedString("Bookmarks", value: "Bookmarks", comment: "Screen title: Bookmarks")
    static let user = NSLocalizedString("Profile", value: "Profile", comment: "Screen title: Profile")
}


enum Subtitle {
    static let categories = NSLocalizedString("Thousands of articles in each category", value: "Thousands of articles in each category", comment: "Subtitle: Categories")
    static let browse = NSLocalizedString("Discover things of the world", value: "Discover things of the world", comment: "Subtitle: Browse")
    static let bookmarks  = NSLocalizedString("Saved articles to the library", value: "Saved articles to the library", comment: "Subtitle: Bookmarks")
}


enum Placeholder {
    static let search = NSLocalizedString("Search", value: "Search", comment: "Placeholder text for search")
}

enum EmptyListHelper {
    static let noBookmarks = NSLocalizedString("You haven't saved any articles yet. Start reading and bookmarking them now", value: "You haven't saved any articles yet. Start reading and bookmarking them now", comment: "Empty bookmarks list message")
}


enum Key {
    static let apiKey = "3e1f1bb553a84f6586354aa67b06b19f"
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


enum UserDefaultsConstants {
    static let bookmarkedCategoriesKey = "categories_bookmarked"
    static let mainScreenCategoriesSelectedKey = "categories_tags"
    static let selectedLanguageKey = "selected_language"
    
//    static let appGroup = "ddbae45c2e33483d9cec5e18eaa5a82c"
}

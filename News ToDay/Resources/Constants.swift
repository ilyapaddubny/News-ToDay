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


struct ScreenTitle {
    static var home: String { NSLocalizedString("Browse", value: "Browse", comment: "Screen title: Browse").localized }
    static var categories: String { NSLocalizedString("Categories", value: "Categories", comment: "Screen title: Categories").localized }
    static var bookmarks: String { NSLocalizedString("Bookmarks", value: "Bookmarks", comment: "Screen title: Bookmarks").localized }
    static var user: String { NSLocalizedString("Profile", value: "Profile", comment: "Screen title: Profile").localized }
    static var language: String { NSLocalizedString("Language", value: "Language", comment: "Screen title: Language").localized }
    static var termsAndConditions: String { NSLocalizedString("Terms & Conditions", value: "Terms & Conditions", comment: "Screen title: Terms & Conditions").localized}
}

struct ProfileStrings {
    static var language: String { NSLocalizedString("LanBtn", value: "Language", comment: "Language button").localized }
    static var termsAndConditions: String { NSLocalizedString("Terms & Conditions Btn", value: "Terms & Conditions", comment: "Terms & Conditions button label").localized }
    static var signOut: String { NSLocalizedString("signOut", value: "Sign Out", comment: "Sign Out button").localized }
}

struct TermsAndConditionsString {
    static var firstSectionTitle: String { NSLocalizedString("firstSectionTitle", value: "1. Introduction", comment: "Terms And Conditions").localized }
    static var firstSectionText: String { NSLocalizedString("firstSectionText", value: """

These terms and conditions (“Terms”) govern the relationship between you, the user of the News Reader application (the “App”) and the owner of the App, defined as News Reader Inc. (“News Reader”), regarding your use of the App.


""", comment: "Terms And Conditions").localized }
    
    
    static var secondSectionTitle: String { NSLocalizedString("secondSectionTitle", value: "2. Acceptance of Terms", comment: "Terms And Conditions").localized }
    static var secondSectionText: String { NSLocalizedString("secondSectionText", value: """
                                            
                                            By downloading, installing, or using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms. If you do not agree to these Terms, please do not download, install, or use the App.
                                            
                                            
                                            """, comment: "Terms And Conditions").localized }
    
    static var thirdSectionTitle: String { NSLocalizedString("thirdSectionTitle", value: "3. Intellectual Property Rights", comment: "Terms And Conditions").localized }
    static var thirdSectionText: String { NSLocalizedString("thirdSectionText", value: """
                                            
                                            You acknowledge and agree that all intellectual property rights, including but not limited to copyrights, patents, trademarks, and trade secrets, in the App and its content (collectively, the “Content”) belong to News Reader or its licensors. You may not copy, modify, distribute, transmit, display, perform, reproduce, publish, license, sell, rent, sub-license, or otherwise exploit the Content, in whole or in part, without News Reader’s prior written permission.
                                            
                                            
                                            """, comment: "Terms And Conditions").localized }
    
    static var fourthSectionTitle: String { NSLocalizedString("fourthSectionTitle", value: "4. User Content", comment: "Terms And Conditions").localized }
    static var fourthSectionText: String { NSLocalizedString("fourthSectionText", value: """
                                            
                                            The App allows users to submit news articles, photos, videos, or other content (“User Content”). You are solely responsible for the creation, ownership, and legal rights related to the User Content you submit. By submitting User Content to the App, you grant News Reader a non-exclusive, revocable, royalty-free, worldwide license to use, display, distribute, and create derivative works of your User Content in connection with the App, provided that News Reader does not alter the submitted User Content in any way that would constitute misrepresentation.
                                            
                                            
                                            """, comment: "Terms And Conditions").localized }
    
    static var fifthSectionTitle: String { NSLocalizedString("fifthSectionTitle", value: "5. Content Disclaimer", comment: "Terms And Conditions").localized }
    static var fifthSectionText: String { NSLocalizedString("fifthSectionText", value: """
                                                
                                                News Reader is not responsible for the accuracy, completeness, or reliability of any Content. You understand that Content may contain errors or omissions, and News Reader expressly disclaims any liability for such errors or omissions. News Reader is also not responsible for User Content or any other content that you or third parties may provide through the App. You use the App at your own risk.
                                                
                                                """, comment: "Terms And Conditions").localized }
}


struct Subtitle {
    static var categories: String { NSLocalizedString("Thousands of articles in each category", value: "Thousands of articles in each category", comment: "Subtitle: Categories").localized}
    static var browse: String { NSLocalizedString("Discover things of the world", value: "Discover things of the world", comment: "Subtitle: Browse").localized }
    static var bookmarks: String { NSLocalizedString("Saved articles to the library", value: "Saved articles to the library", comment: "Subtitle: Bookmarks").localized }
}

struct Placeholder {
    static var search: String { NSLocalizedString("Search", value: "Search", comment: "Placeholder text for search").localized}
}

struct EmptyListHelper {
    static var noBookmarks: String { NSLocalizedString("You haven't saved any articles yet. Start reading and bookmarking them now", value: "You haven't saved any articles yet. Start reading and bookmarking them now", comment: "Empty bookmarks list message").localized }
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

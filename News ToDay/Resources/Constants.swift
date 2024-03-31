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
    static let arrowBackDark = UIImage(named: "BackIcon")
    static let bookmarkWhite = UIImage(named: "BookmarkWhiteIcon")
    static let shareArrow = UIImage(named: "ForwardWhiteIcon")
    static let searchIcon = UIImage(named: "searchIcon")
    static let emptyBookmarksIcon = UIImage(named: "EmptyBookmarksIcon")
    static let onboardingFirst = UIImage(named: "firstScreen")
    static let onboardingSecond = UIImage(named: "secondScreen")
}


struct ScreenTitleStrings {
    static var browse: String { NSLocalizedString("Browse", value: "Browse", comment: "Screen title: Browse").localized }
    static var profile: String { NSLocalizedString("Profile", value: "Profile", comment: "Screen title: Profile").localized }
    static var categories: String { NSLocalizedString("Categories", value: "Categories", comment: "Screen title: Categories").localized }
    static var categoriesOnboarding: String { NSLocalizedString("Select favorite topics", value: "Select favorite topics", comment: "Screen title: Categories").localized }
    static var bookmarks: String { NSLocalizedString("Bookmarks", value: "Bookmarks", comment: "Screen title: Bookmarks").localized }
    static var user: String { NSLocalizedString("Profile", value: "Profile", comment: "Screen title: Profile").localized }
    static var language: String { NSLocalizedString("Language", value: "Language", comment: "Screen title: Language").localized }
    static var recommended: String { NSLocalizedString("Recommended", value: "Recommended", comment: "Screen title: Recommended").localized }
    static var termsAndConditions: String { NSLocalizedString("Terms & Conditions", value: "Terms & Conditions", comment: "Screen title: Terms & Conditions").localized}
}

struct ProfileStrings {
    static var language: String { NSLocalizedString("LanBtn", value: "Language", comment: "Language button").localized }
    static var termsAndConditions: String { NSLocalizedString("Terms & Conditions Btn", value: "Terms & Conditions", comment: "Terms & Conditions button label").localized }
    static var signOut: String { NSLocalizedString("Sign Out", value: "Sign Out", comment: "Sign Out button").localized }
}

struct SignInStrings {
    static var title: String { NSLocalizedString("Welcome back 👋", value: "Welcome back 👋", comment: "Welcome title").localized }
    static var text: String { NSLocalizedString("I am happy to see you again. You can continue where you left off by logging in.", value: "I am happy to see you again. You can continue where you left off by logging in.", comment: "text").localized }
    static var email: String { NSLocalizedString("Email adress", value: "Email adress", comment: "Email adress title" ).localized }
    static var password: String { NSLocalizedString("Password", value: "Password", comment: "Password title").localized }
    static var enterEmail: String { NSLocalizedString("Enter your mail!", value: "Enter your mail!", comment: "Enter mail title").localized }
    static var enterPassword: String { NSLocalizedString("Enter your password!", value: "Enter your password!", comment: "Enter your password title").localized }
    static var signUp: String { NSLocalizedString("Sign Up", value: "Sign Up", comment: "Sign Up button").localized }
    static var signIn: String { NSLocalizedString("Sign in", value: "Sign in", comment: "Sign in button").localized }
    static var label: String { NSLocalizedString("Don't have an account?", value: "Don't have an account?", comment: "Don't have an account label").localized }
   
}

struct SignUpStrings {
    static var title: String { NSLocalizedString("Welcome to NewsToDay", value: "Welcome to NewsToDay", comment: "Welcome title").localized }
    static var text: String { NSLocalizedString("Hello, I guess you are new around here. You can start using the application after sign up.", value: "Hello, I guess you are new around here. You can start using the application after sign up.", comment: "text").localized }
    static var name: String { NSLocalizedString("User name", value: "User name", comment: "User name title").localized }
    static var email: String { NSLocalizedString("Email adress", value: "Email adress", comment: "Email adress title" ).localized }
    static var password: String { NSLocalizedString("Password", value: "Password", comment: "Password title").localized }
    static var repeatPassword: String { NSLocalizedString("Repeat Password", value: "Repeat Password", comment: "Repeat Password title").localized }
    static var enterName: String { NSLocalizedString("Enter your name!", value: "Enter your name!", comment: "Enter name title").localized }
    static var enterEmail: String { NSLocalizedString("Enter your mail!", value: "Enter your mail!", comment: "Enter mail title").localized }
    static var enterPassword: String { NSLocalizedString("Enter your password!", value: "Enter your password!", comment: "Enter your password title").localized }
    static var enterRepeatPassword: String { NSLocalizedString("Repeat your Password!", value: "Repeat your Password!", comment: "Repeat your Password title").localized }
    static var signUp: String { NSLocalizedString("Sign Up", value: "Sign Up", comment: "Sign Up button").localized }
    static var signIn: String { NSLocalizedString("Sign in", value: "Sign in", comment: "Sign in button").localized }
    static var label: String { NSLocalizedString("Already have an account?", value: "Already have an account?", comment: "Already have an account label").localized }
   
}

struct BrowseStrings {
    static var seeAll: String { NSLocalizedString("See all", value: "See all", comment: "Recommended header").localized }
    static var recommendedForYou: String { NSLocalizedString("Recommended for you", value: "Recommended for you", comment: "Recommended header").localized }
}

struct OnboardingStrings {
    static var nextButton: String { NSLocalizedString("Next", value: "Next", comment: "Next button").localized }
}

struct LanguageStrings {
    static var russian: String { NSLocalizedString("Russian", value: "Russian", comment: "Language button").localized }
    static var english: String { NSLocalizedString("English", value: "English", comment: "Language button").localized }
}


struct CategoryStringsWithEmoji {
    static var general: String { NSLocalizedString("🌐  General", value: "🌐  General", comment: "Category: General").localized }
    static var business: String { NSLocalizedString("💼  Business", value: "💼  Business", comment: "Category: Business").localized }
    static var sports: String { NSLocalizedString("⚽️  Sports", value: "⚽️  Sports", comment: "Category: Sports").localized }
    static var entertainment: String { NSLocalizedString("🎉  Leisure", value: "🎉  Leisure", comment: "Category: Entertainment").localized }
    static var science: String { NSLocalizedString("🔬  Science", value: "🔬  Science", comment: "Category: Science").localized }
    static var health: String { NSLocalizedString("💊  Health", value: "💊  Health", comment: "Category: Health").localized }
    static var technology: String { NSLocalizedString("📱  Digital", value: "📱  Digital", comment: "Category: Technology").localized }
}

struct CategoryStrings {
    static var general: String { NSLocalizedString("General", value: "General", comment: "Category: General").localized }
    static var business: String { NSLocalizedString("Business", value: "Business", comment: "Category: Business").localized }
    static var sports: String { NSLocalizedString("Sports", value: "Sports", comment: "Category: Sports").localized }
    static var entertainment: String { NSLocalizedString("Leisure", value: "Leisure", comment: "Category: Leisure").localized }
    static var science: String { NSLocalizedString("Science", value: "Science", comment: "Category: Science").localized }
    static var health: String { NSLocalizedString(" Health ", value: " Health ", comment: "Category: Health").localized }
    static var technology: String { NSLocalizedString("Digital", value: "Digital", comment: "Category: Digital").localized }
}





struct Subtitle {
    static var categories: String { NSLocalizedString("Thousands of articles in each category", value: "Thousands of articles in each category", comment: "Subtitle: Categories").localized}
    static var categoriesOnboarding: String { NSLocalizedString("Select some of your favorite topics to let us suggest better news for you", value: "Select some of your favorite topics to let us suggest better news for you", comment: "Subtitle: onboarding Categories").localized}
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
    static let apiKey = "479c5ce55e1f4a1abc3d42d383da8a96"
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
    static let mainScreenCategoriesSelectedKey = "category_tags"
    static let selectedLanguageKey = "selected_language"
    
    
    static let userLoggedIn = "userLoggedIn"
    static let listOfUsers = "listOfUsers"
    
//    static let appGroup = "ddbae45c2e33483d9cec5e18eaa5a82c"
}

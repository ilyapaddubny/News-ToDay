//
//  NTDTabBarController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.
//

import UIKit

class NTDTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
       viewControllers = [createHomeNC(), createCategoriesNC(), createBookmarksNC(), createProfileNC()]
    }

    
    func createHomeNC() -> UINavigationController {
        let homeVC        = HomeViewController()
        homeVC.title      = ScreenTitles.home
        homeVC.tabBarItem = UITabBarItem(title: nil, image: TabBarImages.home, selectedImage: TabBarSelectedImages.home)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createCategoriesNC() -> UINavigationController {
        let categoriesVC         = CategoriesViewController()
        categoriesVC.title       = ScreenTitles.categories
        categoriesVC.tabBarItem  = UITabBarItem(title: nil, image: TabBarImages.categories, selectedImage: TabBarSelectedImages.categories)
        return UINavigationController(rootViewController: categoriesVC)
    }

    
    func createBookmarksNC() -> UINavigationController {
        let bookmarksVC         = BookmarksViewController()
        bookmarksVC.title       = ScreenTitles.bookmarks
        bookmarksVC.tabBarItem  = UITabBarItem(title: nil, image: TabBarImages.bookmarks, selectedImage: TabBarSelectedImages.bookmarks)
        return UINavigationController(rootViewController: bookmarksVC)
    }
    
    
    func createProfileNC() -> UINavigationController {
        let profileVC         = ProfileViewController()
        profileVC.title       = ScreenTitles.user
        profileVC.tabBarItem  = UITabBarItem(title: nil, image: TabBarImages.user, selectedImage: TabBarSelectedImages.user)
        return UINavigationController(rootViewController: profileVC)
    }
}


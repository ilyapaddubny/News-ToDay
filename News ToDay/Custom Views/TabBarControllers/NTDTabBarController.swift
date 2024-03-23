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
        tabBar.backgroundColor = .systemGray6
    }
    
    
    func createHomeNC() -> UINavigationController {
        let homeVC        = HomeViewController()
        homeVC.title      = ScreenTitle.home
        homeVC.tabBarItem = UITabBarItem(title: nil, image: TabBarImage.home, selectedImage: TabBarSelectedImage.home)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createCategoriesNC() -> UINavigationController {
        let categoriesVC         = CategoriesViewController()
        categoriesVC.title       = ScreenTitle.categories
        categoriesVC.tabBarItem  = UITabBarItem(title: nil, image: TabBarImage.categories, selectedImage: TabBarSelectedImage.categories)
        return UINavigationController(rootViewController: categoriesVC)
    }
    
    
    func createBookmarksNC() -> UINavigationController {
        let bookmarksVC         = BookmarksViewController()
        bookmarksVC.title       = ScreenTitle.bookmarks
        bookmarksVC.tabBarItem  = UITabBarItem(title: nil, image: TabBarImage.bookmarks, selectedImage: TabBarSelectedImage.bookmarks)
        return UINavigationController(rootViewController: bookmarksVC)
    }
    
    
    func createProfileNC() -> UINavigationController {
        let profileVC         = ProfileViewController()
        profileVC.title       = ScreenTitle.user
        profileVC.tabBarItem  = UITabBarItem(title: nil, image: TabBarImage.user, selectedImage: TabBarSelectedImage.user)
        return UINavigationController(rootViewController: profileVC)
    }
}


//
//  CollectionItem.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 25.03.2024.
//

import Foundation

enum CollectionItem: Hashable {
    case news(Article, UUID)
    case category(Category)
    
    var news: Article? {
        if case .news(let article, _) = self {
            return article
        } else {
            return nil
        }
    }
    
    var category: Category? {
        if case .category(let category) = self {
            return category
        } else {
            return nil
        }
    }
    
    static var categories: [CollectionItem] {
        return Category.categories.map { CollectionItem.category($0) }
    }
    static var categoriesSortedABC: [CollectionItem] {
        return Category.categoriesSortedABC.map { CollectionItem.category($0) }
    }
    static var promotedNews: [CollectionItem] {
        return Article.promotedNews.map { CollectionItem.news($0, UUID()) }
    }
    static var recommendedNews: [CollectionItem] {
        return Article.recommendedNews.map { CollectionItem.news($0, UUID()) }
    }
    static var bookmarkedArticles: [CollectionItem] {
        return Article.bookmarkedArticles.map { CollectionItem.news($0, UUID()) }
    }
    
}

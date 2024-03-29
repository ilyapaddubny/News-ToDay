//
//  News.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 19.03.2024.
//

import Foundation

fileprivate func transformToArticleObject(favorite: Favorite) -> Article {
    let source = Source(name: favorite.source?.name ?? "unknown")
    return Article(
        source: source,
        author: favorite.author,
        title: favorite.title,
        description: favorite.newsDescription,
        url: nil,
        urlToImage: favorite.urlToImage,
        publishedAt: nil,
        content: favorite.content)
    
}

struct News: Codable, Hashable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}


struct Article: Codable, Hashable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    
    static var bookmarkedArticles: [Article] {
        return StorageManager.shared.fetchFavorites().map { transformToArticleObject(favorite: $0) }
    }
        
    var isBookmarked: Bool {
        // надо получать из кор-даты массив типа [Article] и возвращать значение [Article].contains(self)
        get {
            return Article.bookmarkedArticles.contains(self)
        }
        
        set {
            // если мы убираем кейс из избранного, нужно удалить его из массива
            if Article.bookmarkedArticles.first(where: {$0.title == self.title}) != nil, !newValue {
//                Article.bookmarkedArticles.removeAll(where: {$0.title == self.title})
                StorageManager.shared.deleteFavorite(self)
            }
            // если мы добавляем кейс в избранное, нужно его добавить в массив
            if newValue {
//                Article.bookmarkedArticles.append(self)
                StorageManager.shared.saveToFavorites(self)
            }
        }
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
           return lhs.title == rhs.title
       }
    
    static let promotedNews: [Article] = [
    ]
    
    static var recommendedNews: [Article] = [
    ]
    
   
}


struct Source: Codable, Hashable {
    let name: String
}

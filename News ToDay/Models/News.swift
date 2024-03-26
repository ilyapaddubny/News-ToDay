//
//  News.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 19.03.2024.
//

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}


struct Article: Codable, Hashable, Equatable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    
    static var bookmarkedArticles: [Article] = []
    
    var isBookmarked: Bool {
        // надо получать из кор-даты массив типа [Article] и возвращать значение [Article].contains(self)
        get {
            //TODO: (Для Миши) Article.isBookmarked получать из core-data
            return Article.bookmarkedArticles.contains(self)
        }
        
        //TODO: (Для Миши) Article.isBookmarked получать и записывать в core-data
        set {
            // если мы убираем кейс из избранного, нужно удалить его из массива
            if Article.bookmarkedArticles.first(where: {$0.url == self.url}) != nil, !newValue {
                Article.bookmarkedArticles.removeAll(where: {$0.url == self.url})
            }
            // если мы добавляем кейс в избранное, нужно его добавить в массив
            if newValue {
                Article.bookmarkedArticles.append(self)
            }
        }
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
           return lhs.url == rhs.url
       }
    
    static let promotedNews: [Article] = [
    ]
    
    static var recommendedNews: [Article] = [
    ]
    
   
}


struct Source: Codable, Hashable {
    let name: String
}

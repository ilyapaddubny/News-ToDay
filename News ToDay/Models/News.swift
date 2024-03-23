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


struct Article: Codable, Hashable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    static let promotedNews: [Article] = [
//        Article(source: nil, author: "John Doe", title: "Study Shows Benefits of Meditation", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Alice Johnson", title: "New Technology Aids in Environmental Conservation", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "David Brown", title: "Health Experts Recommend Plant-Based Diet for Longevity", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Sarah Miller", title: "Breakthrough Discovery in Cancer Treatment", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Emma Taylor", title: "Innovations in Renewable Energy Technology", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)
    ]
    
    static var recommendedNews: [Article] = [
//        Article(source: nil, author: "Michael Green", title: "New Study Reveals Surprising Benefits of Chocolate", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Sophia White", title: "Space Exploration: Latest Developments and Future Prospects", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Ryan Johnson", title: "Artificial Intelligence: Transforming Industries Across the Globe", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Olivia Davis", title: "The Future of Transportation: Electric Vehicles and Beyond", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Daniel Adams", title: "Advancements in Virtual Reality Technology", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Sophia Smith", title: "Exploring the Mysteries of Deep Sea Ecosystems", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Ethan Brown", title: "Revolutionizing Education: Impact of Online Learning Platforms", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
//        Article(source: nil, author: "Isabella White", title: "The Rise of Sustainable Fashion: Ethical Practices in the Industry", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)
    ]
}


struct Source: Codable, Hashable {
    let name: String
}

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
}


struct Source: Codable, Hashable {
    let name: String
}

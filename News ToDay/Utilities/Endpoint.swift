//
//  Endpoint.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 19.03.2024.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}


extension Endpoint {
    
    static func searchEverything(matching query: String) -> Endpoint {
        return Endpoint(
            path: "/v2/everything",
            queryItems: [
                URLQueryItem(name: "q", value: query)
            ]
        )
    }
    
    
    static func searchTopHeadlines(categories: [String], countries: [String]) -> Endpoint {
        var categoriesQueryItems: [URLQueryItem] = []
        categories.forEach {
            let item = URLQueryItem(name: "category", value: $0)
            categoriesQueryItems.append(item)
        }
        var countriesQueryItems: [URLQueryItem] = []
        countries.forEach {
            let item = URLQueryItem(name: "country", value: $0)
            countriesQueryItems.append(item)
        }
        return Endpoint(
            path: "/v2/top-headlines",
            queryItems: categoriesQueryItems + countriesQueryItems
        )
    }
}


extension Endpoint {
  
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

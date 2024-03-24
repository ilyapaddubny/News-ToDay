//
//  NetworkManager.swift
//  AwaitNetworkCall
//
//  Created by Mikhail Ustyantsev on 13.03.2024.
//

import UIKit

final class NetworkManager {
    
    static let shared   = NetworkManager()
    
    private init() {}
    
    
    func retrieveNews(from url: URL) async throws -> News {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.addValue(Key.apiKey, forHTTPHeaderField: httpHeaderField.xApiKey)
        let (data, _) = try await session.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(News.self, from: data)
    }
}

//
//  NetworkManager.swift
//  AwaitNetworkCall
//
//  Created by Mikhail Ustyantsev on 13.03.2024.
//

import UIKit

final class NetworkManager {
    
    static let shared   = NetworkManager()
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func retrieveNews(from url: URL) async throws -> News {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.addValue(Key.apiKey, forHTTPHeaderField: httpHeaderField.xApiKey)
        let (data, _) = try await session.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(News.self, from: data)
    }
    
    
    func downloadImage(from urlString: String) async -> UIImage? {
            let cacheKey   = NSString(string: urlString)
            if let image   = cache.object(forKey: cacheKey) {
                return image
            }
            
            guard let url = URL(string: urlString) else {
                return nil
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else { return nil }
                self.cache.setObject(image, forKey: cacheKey)
                return image
            } catch {
                return nil
            }
        }

}

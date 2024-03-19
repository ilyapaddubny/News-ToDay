//
//  HomeViewController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.
//

import UIKit

class HomeViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let healthCategory = Category.health.rawValue
        let business = Category.business.rawValue
        let uSA = Country.USA
        let gB = Country.GreatBritain
        
        guard let url = Endpoint.searchTopHeadlines(categories: [healthCategory, business], countries: [uSA, gB]).url else { return
        }
    
        Task {
            let news = try? await NetworkManager.shared.retrieveNews(from: url)
            guard let news = news else { return }
            news.articles.forEach {
                print($0.title ?? "")
            }
        }
    }
    
}

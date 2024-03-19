//
//  HomeViewController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.
//

import UIKit



class HomeViewController: BaseController {
    
    enum Section: Hashable {
        case categories, promoted, recommended
    }
    
    enum SupplemenntaryViewKind {
        static let header = "header"
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        
        collectionView.register(CategoryTagCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryTagCollectionViewCell.reuseIdentifier)
        collectionView.register(PromotedArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: PromotedArticleCollectionViewCell.reuseIdentifier)
        collectionView.register(StandardArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: StandardArticleCollectionViewCell.reuseIdentifier)
        
        configureDataSource()
        
        
//        // Initialize collection view layout
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical // Set the scroll direction
        
        // Initialize collection view
        
        
        self.view.addSubview(collectionView)
    }
    
    func createLayout() -> UICollectionViewLayout  {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = self.sections[sectionIndex]
            switch section {
            case .categories:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(100),
                    heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(56.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous // horizontal scroolling
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 0)
                return section
            case .promoted:
                // MARK: Promoted Section Layout
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
                
               
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.75),
                    heightDimension: .estimated(256))
                let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
               
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging // horizontal scroolling
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
                return section
                
            case.recommended:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                
                let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1),
                                                        heightDimension: .estimated(112))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(16)
                
                
                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .groupPaging // horizontal scroolling
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
                return section
                
            }
        }
        return layout
    }
    
    func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            switch section {
            case .categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryTagCollectionViewCell.reuseIdentifier,
                                                              for: indexPath) as! CategoryTagCollectionViewCell
                cell.configureCellWith(item.category!)
                return cell
            case .promoted:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotedArticleCollectionViewCell.reuseIdentifier,
                                                              for: indexPath) as! PromotedArticleCollectionViewCell
                cell.configureCellWith(item.news!)
                return cell
            case .recommended:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandardArticleCollectionViewCell.reuseIdentifier,
                                                              for: indexPath) as! StandardArticleCollectionViewCell
                cell.configureCellWith(item.news!)
                return cell
            }
        });
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.categories])
        snapshot.appendItems(Item.categories, toSection: .categories)
        
        snapshot.appendSections([.promoted])
        snapshot.appendItems(Item.promotedNews, toSection: .promoted)
        
        snapshot.appendSections([.recommended])
        snapshot.appendItems(Item.reccomendedNews, toSection: .recommended)
        
        sections = snapshot.sectionIdentifiers
        dataSource.apply(snapshot)
    }

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


// MARK: - Mock models

enum Item: Hashable {
    case news(NewsArticle)
    case category(NewsCategory)
    
    var news: NewsArticle? {
        if case .news(let news) = self {
            return news
        } else {
            return nil
        }
    }
    
    var category: NewsCategory? {
        if case .category(let category) = self {
            return category
        } else {
            return nil
        }
    }
    
    
    static let promotedNews: [Item] = [
        .news(NewsArticle(headline: "New Study Finds Exercise Increases Productivity", author: "John Doe", category: .health)),
        .news(NewsArticle(headline: "Apple Unveils Latest iPhone Model", author: "Jane Smith", category: .technology)),
        .news(NewsArticle(headline: "Government Passes New Tax Reform Bill", author: "Alex Johnson", category: .politics)),
        .news(NewsArticle(headline: "Football Team Wins Championship", author: "David Brown", category: .sports)),
        .news(NewsArticle(headline: "Netflix Releases Highly Anticipated Series", author: "Emily White", category: .entertainment)),
    ]
    
    static let reccomendedNews: [Item] = [
        .news(NewsArticle(headline: "New Study Finds Exercise Increases Productivity", author: "John Doe", category: .sports)),
        .news(NewsArticle(headline: "Apple Unveils Latest iPhone Model", author: "Jane Smith", category: .technology)),
        .news(NewsArticle(headline: "Government Passes New Tax Reform Bill", author: "Alex Johnson", category: .politics)),
        .news(NewsArticle(headline: "Football Team Wins Championship", author: "David Brown", category: .sports)),
        .news(NewsArticle(headline: "Netflix Releases Highly Anticipated Series", author: "Emily White", category: .entertainment)),
        .news(NewsArticle(headline: "Breakthrough in Renewable Energy Research", author: "Michael Green", category: .technology)),
        .news(NewsArticle(headline: "Stock Market Reaches All-Time High", author: "Sarah Johnson", category: .business)),
        .news(NewsArticle(headline: "Hollywood Actress Wins Oscar Award", author: "Christopher Black", category: .entertainment)),
        .news(NewsArticle(headline: "Global Leaders Meet to Discuss Climate Change", author: "Emma Taylor", category: .politics)),
        .news(NewsArticle(headline: "World Cup Finals Scheduled for Next Year", author: "Daniel Adams", category: .sports)),
    ]
    
    static let categories: [Item] = [
        .category(.business),
        .category(.health),
        .category(.technology),
        .category(.politics),
        .category(.entertainment),
    ]
    
}


struct NewsArticle: Hashable {
    let headline: String?
    let author: String?
    let category: NewsCategory?
    
    let color = UIColor.random
}

enum NewsCategory: String, Hashable {
    case sports = "Sport"
    case health = "Health"
    case technology = "Technology"
    case politics = "Politics"
    case entertainment = "Entertainment"
    case business = "Business"
    
    // Method to get a string representation of the enum case
    func toString() -> String {
        return self.rawValue
    }
}



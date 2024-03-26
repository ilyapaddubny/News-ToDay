//
//  RecommendedArticlesViewController.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 26.03.2024.
//

import UIKit

class RecommendedArticlesViewController: BaseController {
    
    var recommendedArticles = [CollectionItem]()
    
    var activityIndicator: UIActivityIndicatorView!

    enum Section: Hashable {
        case recommended
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CollectionItem>!
    
    var sections = [Section]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDataSource()
        collectionView.reloadData()
        getNews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        activityIndicator.startAnimating()
        
        configureCollectionView()
        configureDataSource()
        
        collectionView.delegate = self
    }
    
    private func configureActivityIndicator() {
        // Create and configure the activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .buttonActiveColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        // Center the activity indicator in the view
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        
        collectionView.register(StandardArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: StandardArticleCollectionViewCell.reuseIdentifier)
        configureDataSource()
        self.view.addSubview(collectionView)
    }
    
    func createLayout() -> UICollectionViewLayout  {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = self.sections[sectionIndex]
            
            switch section {
                
            case.recommended:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(112))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2)
                
                
                let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1),
                                                        heightDimension: .estimated(336))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                              leading: 20,
                                                              bottom: 0,
                                                              trailing: 20)
                
                let section = NSCollectionLayoutSection(group: group)
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
            case .recommended:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandardArticleCollectionViewCell.reuseIdentifier,
                                                              for: indexPath) as! StandardArticleCollectionViewCell
                cell.configureCellWith(item.news!)
                return cell
            }
        });
        
        // MARK: Snapshot Definition
        var snapshot = NSDiffableDataSourceSnapshot<Section, CollectionItem>()
        snapshot.appendSections([.recommended])
        snapshot.appendItems(CollectionItem.bookmarkedArticles, toSection: .recommended)
        
        sections = snapshot.sectionIdentifiers
        dataSource.apply(snapshot)
    }
    
    // MARK: - Retriving data
    
    func getNews() {
        let category = Category.entertainment.rawValue
        let country = Country.usa
        activityIndicator.isHidden = false
        collectionView.isHidden = true
        guard let url = Endpoint.searchTopHeadlines(categories: [category], countries: [country]).url else { return
        }
        
        Task {
            let news = try? await NetworkManager.shared.retrieveNews(from: url)
            guard let news = news else { return }
            //TODO: reload data
            let items = news.articles.map { CollectionItem.news($0, UUID()) }
            
            print(items.isEmpty ? "⚠️ No reccomended articles from API" : "\(items.count) reccomended articles retrived from API")
            recommendedArticles = items
            DispatchQueue.main.async {
                // Update existing data source snapshot with new recommended articles
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .recommended))
                snapshot.appendItems(self.recommendedArticles, toSection: .recommended)
                self.dataSource.apply(snapshot, animatingDifferences: true)
                self.activityIndicator.isHidden = true
                self.collectionView.isHidden = false
            }
        }
    }
    
    
        
}


extension RecommendedArticlesViewController: UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        
        switch item {
        case .news(let article, _):
            let newsViewController = NewsViewController(category: "entertainment", article: article)
            navigationController?.pushViewController(newsViewController, animated: true)
        case .category(_):
            return
        }
    }
    
}

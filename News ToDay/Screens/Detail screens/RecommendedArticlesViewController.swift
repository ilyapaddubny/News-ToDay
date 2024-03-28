//
//  RecommendedArticlesViewController.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 26.03.2024.
//

import UIKit

class RecommendedArticlesViewController: BaseController {
    let logoLabel = UILabel()
    var recommendedArticles = [CollectionItem]()
    
    lazy var backButton: UIButton = {
        let button = UIButton(primaryAction: back())
        button.setImage(Image.arrowBackWhite, for: .normal)
        button.tintColor = .textOnDisabledButtonColor
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.widthAnchor.constraint(equalToConstant: 26).isActive = true
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
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
        navigationController?.navigationBar.isHidden = true
        configureActivityIndicator()
        activityIndicator.startAnimating()
        setUI()
        configureDataSource()
        collectionView.delegate = self
        
    }
    
    
    func setUI() {
        logoLabel.text = ScreenTitleStrings.termsAndConditions
        logoLabel.font = UIFont(name: "Inter-SemiBold" , size: 25)
        logoLabel.textColor = .textPrimaryColor
        logoLabel.textAlignment = .center
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        view.addSubview(logoLabel)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
        ])
        
        
        
        configureCollectionView()
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
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        
        collectionView.register(StandardArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: StandardArticleCollectionViewCell.reuseIdentifier)
        configureDataSource()
        
        
        
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
        navigationController?.navigationBar.isHidden = true

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
            recommendedArticles = items.filter({$0.news?.title != "[Removed]"})
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
    
    func back() -> UIAction {
        let action = UIAction(title: "", image: nil) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
            self?.navigationController?.navigationBar.isHidden = false
        }
        return action
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



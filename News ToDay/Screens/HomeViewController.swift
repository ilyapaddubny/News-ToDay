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
    
    var recommendedArticles: [Item] = Item.recommendedNews
    
    let searchController = UISearchController()
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        
        collectionView.register(CollectionHeaderReusableView.self,
                                forSupplementaryViewOfKind: SupplemenntaryViewKind.header,
                                withReuseIdentifier: CollectionHeaderReusableView.reuseIdentifire)
        
        collectionView.register(CategoryTagCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryTagCollectionViewCell.reuseIdentifier)
        collectionView.register(PromotedArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: PromotedArticleCollectionViewCell.reuseIdentifier)
        collectionView.register(StandardArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: StandardArticleCollectionViewCell.reuseIdentifier)
        
        configureDataSource()
        
        testAPI()
        
        self.view.addSubview(collectionView)
    }
    
    
//    override func configureViews() {
//        super.configureViews()
//        descriptionLabel.text = "Discover things of this world"
//        view.backgroundColor = .systemBackground
//    }
    
    
    func createLayout() -> UICollectionViewLayout  {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92),
                                                        heightDimension: .estimated(44))
            
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize,
                                                                         elementKind: SupplemenntaryViewKind.header,
                                                                         alignment: .top)
            headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
            
            let section = self.sections[sectionIndex]
            
            let supplementaryItemContentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 4,
                bottom: 0,
                trailing: 4)
            headerItem.contentInsets = supplementaryItemContentInsets
            
            switch section {
            case .categories:
                let estimatedItemWidth = self.calculateMaxCategoryWidth() // Calculate width
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(estimatedItemWidth), // Use calculated width
                    heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(52.0))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 12,
                                            leading: 0,
                                            bottom: 0,
                                            trailing: 0)
                group.interItemSpacing = .fixed(20.0)
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous // horizontal scrolling
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: -20)
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
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 0)
                return section
                
                
            case.recommended:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(112))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2)
                

                let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(0.9),
                                                        heightDimension: .estimated(336))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
                group.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                             leading: 1,
                                                             bottom: 0,
                                                             trailing: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.boundarySupplementaryItems = [headerItem]
                
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
        
        // MARK: Supplementary View Provider
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case SupplemenntaryViewKind.header:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: SupplemenntaryViewKind.header,
                                                                                 withReuseIdentifier: CollectionHeaderReusableView.reuseIdentifire,
                                                                                 for: indexPath) as! CollectionHeaderReusableView
                let section = self.sections[indexPath.section]
                let sectionName: String
                    switch section {
                    case .recommended:
                        sectionName = "Recommended for you"
                    default:
                        return nil
                    }
                
                
                headerView.setTitle(sectionName)
                return headerView
            default:
                return nil
            }
        }
        
        // MARK: Snapshot Definition
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.categories])
        snapshot.appendItems(Item.categories, toSection: .categories)
        
        snapshot.appendSections([.promoted])
        snapshot.appendItems(Item.promotedNews, toSection: .promoted)
        
        snapshot.appendSections([.recommended])
        snapshot.appendItems(recommendedArticles, toSection: .recommended)
        
        sections = snapshot.sectionIdentifiers
        dataSource.apply(snapshot)
    }

    func testAPI() {
        
        let healthCategory = Category.health.rawValue
        let business = Category.business.rawValue
        let uSA = Country.USA
        let gB = Country.GreatBritain
        
        guard let url = Endpoint.searchTopHeadlines(categories: [healthCategory, business], countries: [uSA, gB]).url else { return
        }
    
        Task {
            let news = try? await NetworkManager.shared.retrieveNews(from: url)
            guard let news = news else { return }
            //TODO: reload data
            let items = news.articles.map { Item.news($0, UUID()) }
            print(items.isEmpty ? "⚠️ No items from API" : "\(items.count) articles retrived from API")
            recommendedArticles = items
            DispatchQueue.main.async {
                
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.categories])
                snapshot.appendItems(Item.categories, toSection: .categories)
                
                snapshot.appendSections([.promoted])
                snapshot.appendItems(Item.promotedNews, toSection: .promoted)
                
                snapshot.appendSections([.recommended])
                snapshot.appendItems(self.recommendedArticles, toSection: .recommended)
                
                self.sections = snapshot.sectionIdentifiers
                self.dataSource.apply(snapshot)
                
                
                // Or, if you want to reload specific sections:
//                 collectionView.reloadSections(IndexSet(integer: sectionIndex))
            }
        }
    }
    
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        
        searchController.searchBar.searchTextField.leftView = configureSearchIcon()
        searchController.searchBar.searchTextField.tintColor = .textOnDisabledButtonColor

        searchController.searchBar.tintColor = .textPrimaryColor // Change the color of the search icon and cursor

    }
    
    func configureSearchIcon() -> UIView {
        let imageView = UIImageView(image: Icons.search)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView()
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        paddingView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        paddingView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        let paddingView1 = UIView()
        paddingView1.translatesAutoresizingMaskIntoConstraints = false
        paddingView1.widthAnchor.constraint(equalToConstant: 20).isActive = true
        paddingView1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        stackView.addArrangedSubview(paddingView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(paddingView1)
        return stackView
        
    }
    
}

// MARK: - Searh delegate

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text,
           searchString.isEmpty == false {
            print("User input: \(searchString)") // TODO: Implement the search logic
            
        }
    }
    
    func calculateMaxCategoryWidth() -> CGFloat {
        let categories = Item.categories.map { $0.category! } // Get the category strings
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-SemiBold", size: 17)! // Use the font of your cell
        ]

        let maxWidth = categories.map {
            $0.getButtonName().size(withAttributes: textAttributes).width
        }.max() ?? 0

        return maxWidth - 15
    }
    
}


// MARK: - Model

enum Item: Hashable {
    case news(Article, UUID)
    case category(Category)
    
    var news: Article? {
        if case .news(let article, _) = self {
            return article
        } else {
            return nil
        }
    }
    
    var category: Category? {
        if case .category(let category) = self {
            return category
        } else {
            return nil
        }
    }
    
    static let categories: [Item] = Category.categories.map { Item.category($0) }
    static var promotedNews: [Item] = Article.promotedNews.map { Item.news($0, UUID()) }
    static var recommendedNews: [Item] = Article.recommendedNews.map { Item.news($0, UUID()) }
    
}






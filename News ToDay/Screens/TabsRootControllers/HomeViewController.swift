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
    
    var recommendedArticles: [CollectionItem] = CollectionItem.recommendedNews
    var promotedArticles: [CollectionItem] = CollectionItem.promotedNews
    
    private let searchBar       = UISearchBar()
    private let scrollView      = UIScrollView()
    private let mainStackView   = UIStackView()
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CollectionItem>!
    
    var sections = [Section]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        collectionView.reloadData()
        getRecommendedSectionArticles()
        updateAllStrings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureCollectionView()
        getNews()
        configureDataSource()
        
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChanged(_:)), name: NSNotification.Name("updateLanguage"), object: nil)
    }
    
    
    @objc func languageDidChanged(_ notification: Notification) {
        getNews()
    }
    
    func updateAllStrings() {
        title = ScreenTitleStrings.browse
        setSubtitleText(text: Subtitle.browse)
        searchBar.placeholder = Placeholder.search
        collectionView.reloadData()
    }
    
    
    private func configureSearchBar() {
        //rebome keyboard on tap to any area
        
        
        searchBar.delegate = self
        searchBar.placeholder = Placeholder.search
        searchBar.setLeftImage(Image.searchIcon!, with: 10, tintColor: .textOnDisabledButtonColor)
        searchBar.clearBackgroundColor()
        searchBar.textField?.backgroundColor = .buttonDisabledColor
        searchBar.updateHeight(height: 56)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        let margins = view.safeAreaLayoutGuide
        let offset: CGFloat = 10
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: margins.topAnchor, constant: 32),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            searchBar.heightAnchor.constraint(equalToConstant: 76)
        ])
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(CollectionHeaderReusableView.self,
                                forSupplementaryViewOfKind: SupplemenntaryViewKind.header,
                                withReuseIdentifier: CollectionHeaderReusableView.reuseIdentifire)
        
        collectionView.register(CategoryTagCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryTagCollectionViewCell.reuseIdentifier)
        collectionView.register(PromotedArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: PromotedArticleCollectionViewCell.reuseIdentifier)
        collectionView.register(StandardArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: StandardArticleCollectionViewCell.reuseIdentifier)
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        collectionView.delegate = self
    }
    
    // MARK: - Layout creation
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
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 2)
                
                
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
    
    // MARK: - configureDataSource
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
                headerView.delegate = self
                let section = self.sections[indexPath.section]
                let sectionName: String
                switch section {
                case .recommended:
                    sectionName = BrowseStrings.recommendedForYou
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, CollectionItem>()
        snapshot.appendSections([.categories])
        snapshot.appendItems(CollectionItem.categories, toSection: .categories)
        
        snapshot.appendSections([.promoted])
        snapshot.appendItems(CollectionItem.promotedNews, toSection: .promoted)
        
        snapshot.appendSections([.recommended])
        snapshot.appendItems(recommendedArticles, toSection: .recommended)
        
        sections = snapshot.sectionIdentifiers
        dataSource.apply(snapshot)
    }
    
    // MARK: - Retriving data
    
    func getNews() {
        getPromotedSectionArticles()
        getRecommendedSectionArticles()
    }
    
    func getPromotedSectionArticles() {
        guard let url = getPromotedUrl() else { return }
        
        Task {
            let news = try? await NetworkManager.shared.retrieveNews(from: url)
            guard let news = news else { return }
            //TODO: reload data
            let items = news.articles.map { CollectionItem.news($0, UUID()) }
            
            promotedArticles = items.filter({$0.news?.title != "[Removed]"})
            DispatchQueue.main.async {
                // Update existing data source snapshot with new promoted articles
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .promoted))
                snapshot.appendItems(self.promotedArticles, toSection: .promoted)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
        
        func getPromotedUrl() -> URL? {
            
            let currentLanguage = UserDefaults.standard.string(forKey: "language")
            var country = Country.usa
            if let currentLanguage = currentLanguage {
                switch currentLanguage {
                case "Russian":
                    country = Country.russia
                default:
                    country = Country.usa
                }
            }
            
            guard let currentUser = UserDefaults.standard.user(forKey: UserDefaultsConstants.userLoggedIn) else {return Endpoint.searchTopHeadlines(categories: [], countries: [country]).url}
            
            guard let selectedCategory = currentUser.tagCategory else {
                return Endpoint.searchTopHeadlines(categories: [], countries: [country]).url
            }
            
            return Endpoint.searchTopHeadlines(categories: [selectedCategory.rawValue], countries: [country]).url
        }
    }
    
    func getRecommendedSectionArticles() {
        guard let url = getRecommendedUrl() else { return }
        
        Task {
            let news = try? await NetworkManager.shared.retrieveNews(from: url)
            guard let news = news else { return }
            let items = news.articles.map { CollectionItem.news($0, UUID()) }
            
            recommendedArticles = items.filter({$0.news?.title != "[Removed]"})
            DispatchQueue.main.async {
                    // Update existing data source snapshot with new recommended articles
                    var snapshot = self.dataSource.snapshot()
                    snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .recommended))
                    snapshot.appendItems(self.recommendedArticles, toSection: .recommended)
                    self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
        
        func getRecommendedUrl() -> URL? {
            
            let currentLanguage = UserDefaults.standard.string(forKey: "language")
            var country = Country.usa
            if let currentLanguage = currentLanguage {
                switch currentLanguage {
                case "Russian":
                    country = Country.russia
                default:
                    country = Country.usa
                }
            }
            let currentUser = UserDefaults.standard.user(forKey: UserDefaultsConstants.userLoggedIn)
            let categories = currentUser?.fafouriteCategories ?? []
            
            return Endpoint.searchTopHeadlines(categories: categories.map{$0.rawValue}, countries: [country]).url
        }
        
    }
    
    
    func getArticles(matching request: String) {
        guard let url = Endpoint.searchEverything(matching: request).url else { return }
        
        Task {
            let news = try? await NetworkManager.shared.retrieveNews(from: url)
            guard let news = news else { return }
            let items = news.articles.map { CollectionItem.news($0, UUID()) }
            promotedArticles = items.filter({$0.news?.title != "[Removed]"})
            DispatchQueue.main.async {
                // Update existing data source snapshot with new promoted articles
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .promoted))
                snapshot.appendItems(self.promotedArticles, toSection: .promoted)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
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

extension HomeViewController {
    
    func calculateMaxCategoryWidth() -> CGFloat {
        let categories = CollectionItem.categories.map { $0.category! } // Get the category strings
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-SemiBold", size: 17)! // Use the font of your cell
        ]
        
        let maxWidth = categories.map {
            $0.getButtonName().size(withAttributes: textAttributes).width
        }.max() ?? 0
        
        return maxWidth - 15
    }
    
}


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        
        switch item {
        case .news(let article, _):
            let newsViewController = NewsViewController(category: "entertainment", article: article)
            navigationController?.pushViewController(newsViewController, animated: true)
        case .category(var category):
            guard let currentUser = UserDefaults.standard.user(forKey: UserDefaultsConstants.userLoggedIn) else {return}
            let previouslySelected = currentUser.tagCategory
            category.isSelectedOnTheMainScreen.toggle()
            
            var snapshot = self.dataSource.snapshot()
            snapshot.reloadItems(CollectionItem.categories.filter{($0.category?.rawValue == category.rawValue) || ($0.category?.rawValue == previouslySelected?.rawValue)})
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
            
            getPromotedSectionArticles() //updating promoted news on category tag tap
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryTagCollectionViewCell {
                cell.configureCellWith(category)
            }
        }
    }
}

// MARK: - SeeAll header delegate
extension HomeViewController: CollectionHeaderDelegate {
    func seeAllButtonTapped(_ header: UICollectionReusableView) {
        let recommendedArticlesVC = RecommendedArticlesViewController()
        navigationController?.pushViewController(recommendedArticlesVC, animated: true)

    }
}





//MARK: - SearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.getArticles(matching: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}



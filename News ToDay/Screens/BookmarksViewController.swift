//
//  BookmarksViewController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.
//

import UIKit

class BookmarksViewController: BaseController {
    private let subTitle = NTDLabel(font: Font.interRegular(with: 16), textColor: .textSecondaryColor)

    var emptyStateView = NTDEmptyStateView(message: EmptyListHelper.noBookmarks)
    
    enum Section: Hashable {
        case recommended
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CollectionItem>!
    
    var sections = [Section]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        collectionView.reloadData()
        collectionView.delegate = self
        
        emptyStateView.messageLabel.text = EmptyListHelper.noBookmarks
        subTitle.text = Subtitle.bookmarks
        title = ScreenTitleStrings.bookmarks
        self.tabBarItem.title = nil
        
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureEmptyState() {
        view.addSubview(emptyStateView)
        self.view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        let offset: CGFloat = 16
        subTitle.numberOfLines = 1
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset),
            
            emptyStateView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        
        collectionView.register(StandardArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: StandardArticleCollectionViewCell.reuseIdentifier)
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        let offset: CGFloat = 16
        subTitle.numberOfLines = 1
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset),
            
            collectionView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        
        configureDataSource()
        updateUI()
    }
    
    
    func updateUI() {
        configureEmptyState()
        configureDataSource()
        if CollectionItem.bookmarkedArticles.isEmpty {
            // Collection is empty, show empty state
            emptyStateView.isHidden = false
            collectionView.isHidden = true
        } else {
            // Collection has items, hide empty state
            emptyStateView.isHidden = true
            collectionView.isHidden = false
        }
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
}


extension BookmarksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

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

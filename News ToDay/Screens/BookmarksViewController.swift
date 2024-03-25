//
//  BookmarksViewController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.
//

import UIKit

class BookmarksViewController: BaseController {
    
    var emptyStateView: UIStackView!
    var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 17)
        label.numberOfLines = 0
        label.textColor = .textPrimaryColor
        label.text = EmptyListHelper.noBookmarks
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        configureDataSource()
        
        updateUI()
    }
    
    enum Section: Hashable {
        case recommended
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CollectionItem>!
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        
        collectionView.register(StandardArticleCollectionViewCell.self,
                                forCellWithReuseIdentifier: StandardArticleCollectionViewCell.reuseIdentifier)
        
        configureDataSource()
        
        self.view.addSubview(collectionView)
        
        // Add message label
        emptyStateLabel = UILabel(frame: CGRect(x: 20, y: 100, width: collectionView.bounds.width - 40, height: 100))
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .gray
        view.addSubview(emptyStateLabel)
        
        self.view.addSubview(collectionView)
                
                // Create and configure empty state view
                emptyStateLabel = UILabel()
                emptyStateLabel.font = UIFont(name: "Inter-SemiBold", size: 17)
                emptyStateLabel.numberOfLines = 0
                emptyStateLabel.textColor = .textPrimaryColor
                emptyStateLabel.text = EmptyListHelper.noBookmarks
                emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let imageView = UIImageView(image: UIImage(named: "EmptyBookmarksIcon")) 
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                emptyStateView = UIStackView(arrangedSubviews: [imageView, emptyStateLabel])
                emptyStateView.axis = .vertical
                emptyStateView.alignment = .center
                emptyStateView.spacing = 8
                emptyStateView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(emptyStateView)
                
                NSLayoutConstraint.activate([
                    emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    emptyStateLabel.widthAnchor.constraint(equalToConstant: collectionView.bounds.width - 40),
                    // Add constraints for imageView if needed
                ])
                
                updateUI()
        
    }
    
    
    func updateUI() {
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

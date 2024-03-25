//
//  CategoriesViewController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.
//

import UIKit

class CategoriesViewController: BaseController {
    
    enum Section: Hashable {
        case categories
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        
        
        collectionView.register(CategoryGridCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryGridCollectionViewCell.reuseIdentifier)
        
        configureDataSource()
        
        self.view.addSubview(collectionView)
        
        setSubtitleText(text: Subtitle.categories)
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 20.0
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(72))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        group.interItemSpacing = .fixed(padding)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: padding,
            bottom: 0,
            trailing: padding)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = padding
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: padding,
            leading: 0,
            bottom: padding,
            trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            switch section {
            case .categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryGridCollectionViewCell.reuseIdentifier,
                                                              for: indexPath) as! CategoryGridCollectionViewCell
                cell.configureCellWith(item.category!)
                return cell
            }
        });
        
        
        // MARK: Snapshot Definition
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.categories])
        snapshot.appendItems(Item.categoriesSortedABC, toSection: .categories)
        
        sections = snapshot.sectionIdentifiers
        dataSource.apply(snapshot)
    }
    
}

extension CategoriesViewController: UICollectionViewDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle item selection here
        var selectedItem = dataSource.itemIdentifier(for: indexPath)?.category

        if var selectedItem = dataSource.itemIdentifier(for: indexPath)?.category {
            selectedItem.isBookmarked.toggle()
            
            // Update cell with the updated data
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryGridCollectionViewCell {
                cell.configureCellWith(selectedItem)
            }
        }
    }
    
}

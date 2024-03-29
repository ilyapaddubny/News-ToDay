//
//  OnboardingCategoriesViewController.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 29.03.2024.
//

import Foundation

import UIKit

class OnboardingCategoriesViewController: BaseController {
    private let subTitle = NTDLabel(font: Font.interRegular(with: 16), textColor: .textSecondaryColor)

    enum Section: Hashable {
        case categories
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CollectionItem>!
    
    var sections = [Section]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        reloadStrings()
        
        collectionView.reloadData()
        self.tabBarItem.title = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        collectionView.delegate = self
        configureDataSource()
        collectionView.isScrollEnabled = false
    }
    
    
    func reloadStrings() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let attributedText = NSAttributedString(string: Subtitle.categoriesOnboarding, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        subTitle.attributedText = attributedText
        title = ScreenTitleStrings.categoriesOnboarding
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(CategoryGridGrayCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryGridGrayCollectionViewCell.reuseIdentifier)
        
        self.view.addSubview(subTitle)
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.safeAreaLayoutGuide
        let offset: CGFloat = 16
        
        
        subTitle.numberOfLines = 2
        
        
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset),
            
            collectionView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryGridGrayCollectionViewCell.reuseIdentifier,
                                                              for: indexPath) as! CategoryGridGrayCollectionViewCell
                cell.configureCellWith(item.category!)
                return cell
            }
        });
        
        
        // MARK: Snapshot Definition
        var snapshot = NSDiffableDataSourceSnapshot<Section, CollectionItem>()
        snapshot.appendSections([.categories])
        snapshot.appendItems(CollectionItem.categoriesSortedABC, toSection: .categories)
        
        sections = snapshot.sectionIdentifiers
        dataSource.apply(snapshot)
    }
    
}

extension OnboardingCategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if var selectedItem = dataSource.itemIdentifier(for: indexPath)?.category {
            selectedItem.isBookmarked.toggle()
            
            // Update cell with the updated data
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryGridGrayCollectionViewCell {
                cell.configureCellWith(selectedItem)
            }
        }
    }
    
}

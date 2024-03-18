//
//  NewsFeedVC.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 18.03.2024.
//

import UIKit

class NewsFeedVC: UICollectionViewController {

    private let reuseIdentifier = "Cell" // Standard cell doesn't need a special identifier

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 150)
        
        // Initialize the collection view with the layout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

        collectionView.backgroundColor = .white

        // Standard cell registration
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // ... (Rest of your code: numberOfSections, numberOfItemsInSection remain the same)

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell (Limited options with the standard cell)
        cell.backgroundColor = .lightGray // Example

        // Add labels as subviews
        let headlineLabel = UILabel(frame: CGRect(x: 10, y: 10, width: cell.bounds.width - 20, height: 50))
        headlineLabel.numberOfLines = 2
        cell.contentView.addSubview(headlineLabel)

        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 65, width: cell.bounds.width - 20, height: 70))
        summaryLabel.numberOfLines = 3
        cell.contentView.addSubview(summaryLabel)

        // You'll need to get your headline and summary data from your news source
        headlineLabel.text = "Headline \(indexPath.item + 1)" // Placeholder
        summaryLabel.text = "Summary of the news item goes here..." // Placeholder

        return cell
    }
}


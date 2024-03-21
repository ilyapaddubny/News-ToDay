//
//  CategoryTagCollectionViewCell.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 19.03.2024.
//

import UIKit

class CategoryTagCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoryTagCollectionViewCell"
    
    let categoryButton: TwoStateButton = {
        let button = TwoStateButton(normalBackgroundColor: .buttonActiveColor, highlightedBackgroundColor: .buttonActiveColor)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(categoryButton)
        
        // Apply Constraints
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            categoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            categoryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    
    func configureCellWith(_ category: NewsCategory) {
        categoryButton.setTitle(category.toString(), for: .normal)
        categoryButton.setTitleColor(.textOnActiveButtonColor, for: .normal)
    }
    
}



class TwoStateButton: UIButton {
    
    // Define the two background colors for the button's states
    private let normalBackgroundColor: UIColor
    private let highlightedBackgroundColor: UIColor
    
    // Initialize the button with its normal and highlighted background colors
    init(normalBackgroundColor: UIColor, highlightedBackgroundColor: UIColor) {
        self.normalBackgroundColor = normalBackgroundColor
        self.highlightedBackgroundColor = highlightedBackgroundColor
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        self.backgroundColor = normalBackgroundColor
        self.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
    }
    
    @objc func buttonTouchUp() {
        //TODO: make background swichable
        self.backgroundColor = highlightedBackgroundColor
    }
}

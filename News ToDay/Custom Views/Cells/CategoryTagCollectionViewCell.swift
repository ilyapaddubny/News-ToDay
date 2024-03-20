//
//  CategoryTagCollectionViewCell.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 19.03.2024.
//

import UIKit

class CategoryTagCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoryTagCollectionViewCell"
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        backgroundColor = .buttonDisabledColor
        label.textColor = .textOnDisabledButton
        
        layer.cornerRadius = 20
        
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    
    func configureCellWith(_ category: NewsCategory) {
        label.text = category.toString()
        label.sizeToFit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
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

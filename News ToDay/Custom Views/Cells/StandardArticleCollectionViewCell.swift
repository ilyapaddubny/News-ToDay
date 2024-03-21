//
//  RowNewsCollectionViewCell.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 19.03.2024.
//

import UIKit

class StandardArticleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "StandardArticleCollectionViewCell"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 17
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12.0
        imageView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.backgroundColor = UIColor.random
        
        return imageView
    }()
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 17)
        label.textColor = .textPrimaryColor
        label.numberOfLines = 2
        
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 15)
        label.textColor = .textSecondaryColor
        label.numberOfLines = 1
        
        return label
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.addArrangedSubview(imageView)
        labelStackView.addArrangedSubview(categoryLabel)
        labelStackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(labelStackView)
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellWith(_ article: NewsArticle) {
        headlineLabel.text = article.headline
        categoryLabel.text = article.category?.toString()
    }
    
}

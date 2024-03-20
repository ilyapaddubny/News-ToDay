//
//  PromotedNewsCollectionViewCell.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 19.03.2024.
//

import UIKit

class PromotedArticleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PromotedArticleCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = UIColor.random
        return imageView
    }()
    
    let bookmarkView: UIImageView = {
        let imageView = UIImageView(image: Icons.bookmarkStroke)
        return imageView
    }()
    
    var isBookmarked: Bool = false {
        didSet {
            let bookmarkImage = isBookmarked ? Icons.bookmarkFilled : Icons.bookmarkStroke
            bookmarkView.image = bookmarkImage
        }
    }
    
    let dimmerView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .black
        imageView.layer.opacity = 0.5
        return imageView
    }()
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 17)
        label.textColor = .textOnImageSecondary
        label.numberOfLines = 2
        
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 13)
        label.textColor = .textOnImageSecondary
        label.numberOfLines = 1
        
        return label
    }()
    
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        labelStackView.addArrangedSubview(categoryLabel)
        labelStackView.addArrangedSubview(headlineLabel)
        
        configureLayout()
        
        bookmarkView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bookmarkTapped))
        bookmarkView.addGestureRecognizer(tapGesture)
    }
    
    func configureLayout() {
        addSubview(imageView)
        addSubview(dimmerView)
        addSubview(bookmarkView)
        addSubview(labelStackView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        dimmerView.translatesAutoresizingMaskIntoConstraints = false
        bookmarkView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            dimmerView.topAnchor.constraint(equalTo: topAnchor),
            dimmerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimmerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimmerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            bookmarkView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            bookmarkView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bookmarkView.heightAnchor.constraint(equalToConstant: 30),
            bookmarkView.widthAnchor.constraint(equalTo: bookmarkView.heightAnchor),
            
            labelStackView.heightAnchor.constraint(equalToConstant: 70),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
        
    }
    
    @objc func bookmarkTapped() {
        //TODO: implement bookmark logic here
        
        isBookmarked.toggle()
    }
    
    
    func configureCellWith(_ article: NewsArticle) {
        categoryLabel.text = article.category?.toString().uppercased()
        headlineLabel.text = article.headline
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

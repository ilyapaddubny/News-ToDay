//
//  NewsHeaderTextView.swift
//  News ToDay
//
//  Created by Михаил on 20.03.2024.
//

import UIKit

class NewsHeaderTextView: BaseView {

    let categoryLabel   = PaddingLabel()
    let titleLabel      = NTDLabel(font: Font.interBold(with: 20), textColor: .white)
    let authorNameLabel = NTDLabel(font: Font.interSemiBold(with: 16), textColor: .white)
    let authorLabel     = NTDLabel(font: Font.interRegular(with: 14), textColor: .textGreyLight)
    
    func configure(category: String, article: Article) {
        categoryLabel.text        = category.capitalized
        categoryLabel.sizeToFit()
        titleLabel.text           = article.title
        authorNameLabel.text      = article.author
        authorLabel.text          = "Author"
    }
}

extension NewsHeaderTextView {
    
    override func setupViews() {
        super.setupViews()
        addSubviews(
            categoryLabel,
            titleLabel,
            authorNameLabel,
            authorLabel
        )
    }
    
    
    override func constraintViews() {
        super.constraintViews()
        
        let offset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            
            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            authorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            
            authorLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26)
        ])
    }
    
    
    override func configureAppearance() {
        backgroundColor                   = .clear
            
        categoryLabel.textColor           = .white
        categoryLabel.font                = Font.interSemiBold(with: 12)
        categoryLabel.backgroundColor     = .buttonActiveColor
        categoryLabel.layer.cornerRadius  = 15
        categoryLabel.clipsToBounds       = true
        
        titleLabel.numberOfLines          = 3
    }
}

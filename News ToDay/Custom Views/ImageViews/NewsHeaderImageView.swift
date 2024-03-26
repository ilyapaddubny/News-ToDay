//
//  NewsHeaderImageView.swift
//  News ToDay
//
//  Created by Михаил on 20.03.2024.
//

import UIKit

class NewsHeaderImageView: UIImageView {
    
    let placeholderImage = Image.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        image              = placeholderImage
        contentMode        = .scaleAspectFill
        clipsToBounds      = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}

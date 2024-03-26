//
//  OnboardingCollectionViewCell.swift
//  News ToDay
//
//  Created by admins on 24.03.2024.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - UI
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    //MARK: - Properties
    
    static let idOnboardingCell = "idOnboardingCell"
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Public Methods

extension OnboardingCollectionViewCell {
    
    public func cellConfigure(model: OnboardingModel) {
        mainImage.image = model.mainImage
    }
}


//MARK: - Private Methods

private extension OnboardingCollectionViewCell {
    
    func setupViews() {
        addSubview(mainImage)
        layer.cornerRadius = 12
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mainImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            mainImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
}

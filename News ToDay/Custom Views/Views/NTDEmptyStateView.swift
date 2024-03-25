//
//  NTDEmptyStateView.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 25.03.2024.
//

import UIKit

class NTDEmptyStateView: UIView {

    let logoImageView           = UIImageView(image: Image.emptyBookmarksIcon)
    let logoImageViewContainer  = UIView()
    let messageLabel            = NTDLabel(font: Font.interRegular(with: 16), textColor: .textPrimaryColor)
    let stackView               = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(messageLabel, logoImageView)
        translatesAutoresizingMaskIntoConstraints = false
        configureMessageLabel()
        configureLogoImageViewContainer()
        configureStackView()
    }
    
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines  = 3
        messageLabel.textAlignment  = .center
    }
    
    
    private func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode           = .scaleAspectFit
        logoImageView.backgroundColor       = .clear
        logoImageView.layer.cornerRadius    = 36
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 24),
            logoImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    private func configureLogoImageViewContainer() {
        configureLogoImageView()
        logoImageViewContainer.addSubview(logoImageView)
        logoImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        logoImageViewContainer.backgroundColor       = .systemGray5
        logoImageViewContainer.layer.cornerRadius    = 36
        
        NSLayoutConstraint.activate([
            logoImageViewContainer.widthAnchor.constraint(equalToConstant: 72),
            logoImageViewContainer.heightAnchor.constraint(equalToConstant: 72),
            
            logoImageView.centerYAnchor.constraint(equalTo: logoImageViewContainer.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: logoImageViewContainer.centerXAnchor),
        ])
    }
    
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.axis          = .vertical
        stackView.alignment     = .center
        stackView.distribution  = .fillProportionally
        stackView.spacing       = 24
        stackView.addArrangedSubview(logoImageViewContainer)
        stackView.addArrangedSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
}

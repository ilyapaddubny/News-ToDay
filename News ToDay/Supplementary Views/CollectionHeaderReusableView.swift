//
//  CollectionHeaderReusableView.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 20.03.2024.
//

import UIKit

protocol CollectionHeaderDelegate: AnyObject {
    func seeAllButtonTapped(_ header: UICollectionReusableView)
}

class CollectionHeaderReusableView: UICollectionReusableView {
    static let reuseIdentifire = "CollectionHeaderReusableView"
    weak var delegate: CollectionHeaderDelegate?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 20)
        label.textColor = .textPrimaryColor
        
        return label
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle(BrowseStrings.seeAll, for: .normal)
        button.setTitleColor(.textSecondaryColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.setContentHuggingPriority(.required, for: .horizontal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        ])
        
        addTarget()
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(seeAllButton)
    }
    
    private func addTarget() {
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
    }
    
    @objc func seeAllButtonTapped() {
        delegate?.seeAllButtonTapped(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        label.text = title
        seeAllButton.setTitle(BrowseStrings.seeAll, for: .normal)
    }
    
}

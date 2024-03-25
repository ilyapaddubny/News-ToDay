//
//  CategoryGridCollectionViewCell.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 25.03.2024.
//

import UIKit

class CategoryGridCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoryGridCollectionViewCell"
    
    private var borderColorFlag = false
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 17)
        label.numberOfLines = 1
        label.textColor = .textOnDisabledButtonColor
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }
    
    private func setupCell() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.borderColor = UIColor.buttonDisabledColor.cgColor
        layer.borderWidth  = 1.5
        
        NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: centerXAnchor), // Center label horizontally
                label.centerYAnchor.constraint(equalTo: centerYAnchor) // Center label vertically
            ])
        
    }
    
    
    
    func configureCellWith(_ category: Category) {
        label.text = category.getNamePlusIconString()
        borderColorFlag = category.isBookmarked
        configureCellSelection()
    }
    
    
    private func configureCellSelection() {
        if borderColorFlag {
            layer.borderColor = UIColor.buttonActiveColor.cgColor
            layer.borderWidth  = 2
        } else {
            layer.borderColor = UIColor.buttonDisabledColor.cgColor
            layer.borderWidth  = 1.5
        }
        borderColorFlag.toggle()
    }
}

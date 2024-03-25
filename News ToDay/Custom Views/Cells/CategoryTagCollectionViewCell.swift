//
//  CategoryTagCollectionViewCell.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 19.03.2024.
//

import UIKit

class CategoryTagCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoryTagCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 17)
        label.numberOfLines = 1
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    var isChosen = false
    
    private func setup() {
        backgroundColor = .buttonDisabledColor
        label.textColor = .textOnDisabledButtonColor
        
        layer.cornerRadius = 20
        
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configureCellWith(_ category: Category) {
        label.text = category.getButtonName()
        isChosen = category.isSelectedOnTheMainScreen
        configureCellSelection()
    }
    
    private func configureCellSelection() {
        if isChosen {
            self.backgroundColor = UIColor.buttonActiveColor
            self.label.textColor = UIColor.textOnActiveButtonColor
        } else {
            self.backgroundColor = UIColor.buttonDisabledColor
            self.label.textColor = UIColor.textOnDisabledButtonColor
        }
        isChosen.toggle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}


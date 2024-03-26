//
//  CustomButtonBlue.swift
//  News ToDay
//
//  Created by admins on 24.03.2024.
//

import UIKit

final class BlueButton: UIButton {
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
    }
    
    
    convenience init(text: String) {
        self.init(type: .system)
        setTitle(text, for: .normal)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Private Methods

private extension BlueButton {
    
    func configure() {
        backgroundColor = .buttonActiveColor
        titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 16)
        tintColor = .white
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
    }
}


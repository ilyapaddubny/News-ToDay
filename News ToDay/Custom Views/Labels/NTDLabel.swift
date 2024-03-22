//
//  NTDLabel.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 22.03.2024.
//

import UIKit

class NTDLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(font: UIFont, textColor: UIColor) {
        self.init(frame: .zero)
        self.textColor = textColor
        self.font = font
    }
    
    
    private func configure() {
        adjustsFontSizeToFitWidth     = true
        minimumScaleFactor            = 0.9
        lineBreakMode                 = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}

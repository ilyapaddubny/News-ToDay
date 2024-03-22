//
//  PaddingLabel.swift
//  News ToDay
//
//  Created by Михаил on 20.03.2024.
//

import UIKit

class PaddingLabel: UILabel {
    
    var topInset: CGFloat     = 8.0
    var bottomInset: CGFloat  = 8.0
    var leftInset: CGFloat    = 16.0
    var rightInset: CGFloat   = 16.0
    
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}

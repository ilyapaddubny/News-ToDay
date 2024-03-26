//
//  Extensions.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 19.03.2024.
//

import UIKit


extension UIColor {
    static var random: UIColor {
        UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        
    }
}

// in order to use like:
// label.textColor = .textSecondary
extension UIColor {
    static var accentColor: UIColor {
        return UIColor(named: "AccentColor") ?? .clear
    }
    
    static var buttonActiveColor: UIColor {
        return UIColor(named: "ButtonActiveColor") ?? .clear
    }
    
    static var buttonDisabledColor: UIColor {
        return UIColor(named: "ButtonDisabledColor") ?? .clear
    }
    
    static var textOnActiveButtonColor: UIColor {
        return UIColor(named: "TextOnActiveButtonColor") ?? .clear
    }
    
    static var textOnDisabledButtonColor: UIColor {
        return UIColor(named: "TextOnDisabledButtonColor") ?? .clear
    }
    
    static var textOnImageSecondaryColor: UIColor {
        return UIColor(named: "TextOnImageSecondaryColor") ?? .clear
    }
    
    static var textPrimaryColor: UIColor {
        return UIColor(named: "TextPrimaryColor") ?? .clear
    }
    
    static var textSecondaryColor: UIColor {
        return UIColor(named: "TextSecondaryColor") ?? .clear
    }
    
    static var textGreyLightColor: UIColor {
        return UIColor(named: "TextGreyLight") ?? .clear
    }
}


extension UILabel {
    func getTextSize() -> CGSize {
        guard let text else { return CGSize() }
        let fontName = font.fontName
        let fontSize = font.pointSize
        let font = UIFont(name: fontName, size: fontSize)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = text.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        return CGSize(width: size.width.rounded(),
                      height: size.height.rounded())
    }
}

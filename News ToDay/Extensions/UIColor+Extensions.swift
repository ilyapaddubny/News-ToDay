//
//  UIColor+Extensions.swift
//  News ToDay
//
//  Created by admins on 24.03.2024.
//

import UIKit

extension UIColor {
  enum Colors {
    static let black = UIColor(rgb: 0x141413)
    static let white = UIColor(rgb: 0xF4F4F4)
    static let champagne = UIColor(rgb: 0xF4E9CD)
    static let purpleDarker = UIColor(rgb: 0x2536A7)
    static let purpleLighter = UIColor(rgb: 0xEEF0FB)
    static let blackPrimary = UIColor(rgb: 0x333647)
    static let grayPrimary = UIColor(rgb: 0x7C82A1)
  }

  fileprivate convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }

  fileprivate convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }

}

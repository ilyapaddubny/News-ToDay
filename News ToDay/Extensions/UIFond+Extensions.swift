//
//  UIFond+Extensions.swift
//  News ToDay
//
//  Created by admins on 24.03.2024.
//

import UIKit

extension UIFont {
  enum FontWeight: String {
    case medium = "Medium"
    case bold = "Bold"
  }

  static func size(_ size: CGFloat, weight: FontWeight) -> UIFont {
    let fullFontName = "Inter-\(weight.rawValue)"
    guard let font = UIFont(name: fullFontName, size: size) else {
      fatalError("Font '\(fullFontName)' does not exist.")
    }
    return font
  }
}

//
//  String+Extensions.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 26.03.2024.
//

import Foundation
//TODO: Remove file later

extension String {
    var localized: String {
        return LocalizeUtils.defaultLocalizer.stringForKey(key: self)
    }
}

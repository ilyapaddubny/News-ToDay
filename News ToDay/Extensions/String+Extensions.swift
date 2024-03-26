//
//  String+Extensions.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 26.03.2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
}

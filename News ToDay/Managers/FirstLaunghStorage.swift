//
//  FirstLaunghStorage.swift
//  News ToDay
//
//  Created by admins on 25.03.2024.
//

import Foundation

enum FirstLaunchStorage {
    private static let firstLaunchCompleteKey = "firstLaunchComplete"
    static func setFirstLaunchComplete() {
        UserDefaults.standard.setValue(true, forKey: firstLaunchCompleteKey)
    }
    static var isFirstLaunchComplete: Bool {
        UserDefaults.standard.bool(forKey: firstLaunchCompleteKey)
    }
}

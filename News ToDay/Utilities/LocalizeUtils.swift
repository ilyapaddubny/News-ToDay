//
//  LocalizeUtils.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 27.03.2024.
//

import Foundation

class LocalizeUtils: NSObject {
    static let defaultLocalizer = LocalizeUtils()
    var appbundle = Bundle.main
    
    func setSelectedLanguage(lang: String) {
        guard let langPath = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            appbundle = Bundle.main
            return
        }
        appbundle = Bundle(path: langPath)!
    }
    
    func stringForKey(key: String) -> String {
        return appbundle.localizedString(forKey: key, value: "", table: nil)
    }
}

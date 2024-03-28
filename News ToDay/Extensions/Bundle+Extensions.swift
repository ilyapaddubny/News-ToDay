//
//  Bundle+Extensions.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 26.03.2024.
//

import Foundation

//TODO: Remove file later

//https://nerdzlab.com/localization-changing-language-on-the-fly-in-an-ios-app/

//extension Bundle {
//    private static var bundle: Bundle!
//    
//    public static func localizedBundle() -> Bundle {
//        if bundle == nil {
//            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "ru"
//            if let path = Bundle.main.path(forResource: appLang, ofType: "lproj") {
//                bundle = Bundle(path: path)
//            } else {
//                // Fallback to the base localization if the specified language is not found
//                bundle = Bundle.main
//            }
//        }
//        
//        return bundle
//    }
//    
//    public static func setLanguage(lang: String) {
//        UserDefaults.standard.set(lang, forKey: "app_lang")
//        if let path = Bundle.main.path(forResource: lang, ofType: "lproj") {
//            bundle = Bundle(path: path)
//        } else {
//            // Fallback to the base localization if the specified language is not found
//            bundle = Bundle.main
//        }
//    }
//}

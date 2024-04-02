//
//  AppDelegate.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 18.03.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 3.0)
        
        let currentLanguage = UserDefaults.standard.string(forKey: "language")
        LocalizeUtils.defaultLocalizer.setSelectedLanguage(lang: "en") // Setting the default language to English
        
        if let currentLanguage = currentLanguage {
            switch currentLanguage {
            case "Russian":
                LocalizeUtils.defaultLocalizer.setSelectedLanguage(lang: "ru")
            default:
                LocalizeUtils.defaultLocalizer.setSelectedLanguage(lang: "en")
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    
    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "NewsDataModel")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                //print("DB url -", description.url?.absoluteString)
            }
        }
        return container
    }()
    
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}


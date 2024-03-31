//
//  StorageManager.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 25.03.2024.
//

import UIKit
import CoreData


public final class StorageManager: NSObject {
    
    public static let shared = StorageManager()
    
    
    private override init() {}
    
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    
    func saveToFavorites(_ article: Article) {
        guard let favoriteEntityDescription = NSEntityDescription.entity(forEntityName: "Favorite", in: context) else { return }
        let favorite = Favorite(entity: favoriteEntityDescription, insertInto: context)
        favorite.title = article.title
        favorite.author = article.author
        favorite.newsDescription = article.description
        favorite.content = article.content
        favorite.urlToImage = article.urlToImage
        favorite.user = UserDefaults.standard.user(forKey: UserDefaultsConstants.userLoggedIn)?.email
        appDelegate.saveContext()
    }
    
    
    func fetchFavorites() -> [Favorite] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            guard var currentUser = UserDefaults.standard.user(forKey: UserDefaultsConstants.userLoggedIn) else {return []}
            let favoritesAll = try context.fetch(fetchRequest) as? [Favorite] ?? []
            return favoritesAll.filter{$0.user == currentUser.email}
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    
    func getFavorite(with title: String) -> Favorite? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            guard let favorites = try? context.fetch(fetchRequest) as? [Favorite] else { return nil }
            guard var currentUser = UserDefaults.standard.user(forKey: UserDefaultsConstants.userLoggedIn) else {return nil}

            return favorites.first { ($0.title == title) && ($0.user == currentUser.email) }
        }
    }
    
    
    func deleteFavorite(_ article: Article) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        guard let favorites = try? context.fetch(fetchRequest) as? [Favorite], let favorite = favorites.first(where: {$0.title == article.title}) else { return }
        context.delete(favorite)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    func deleteAllPhoto() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            let favorites = try? context.fetch(fetchRequest) as? [Favorite]
            favorites?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }
}

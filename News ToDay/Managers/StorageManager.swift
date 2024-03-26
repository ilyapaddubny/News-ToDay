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
        favorite.newsDescription = article.description
        favorite.content = article.content
        favorite.urlToImage = article.urlToImage
        
        appDelegate.saveContext()
    }
    
    
    func fetchFavorites() -> [Favorite] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            return try context.fetch(fetchRequest) as? [Favorite] ?? []
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    
    func getFavorite(with title: String) -> Favorite? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            guard let favorites = try? context.fetch(fetchRequest) as? [Favorite] else { return nil }
            return favorites.first { $0.title == title }
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

//
//  Origin+CoreDataProperties.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 27.03.2024.
//
//

import Foundation
import CoreData

@objc(Origin)
public class Origin: NSManagedObject {}

extension Origin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Origin> {
        return NSFetchRequest<Origin>(entityName: "Origin")
    }

    @NSManaged public var name: String?
    @NSManaged public var article: NSSet?

}

// MARK: Generated accessors for article
extension Origin {

    @objc(addArticleObject:)
    @NSManaged public func addToArticle(_ value: Favorite)

    @objc(removeArticleObject:)
    @NSManaged public func removeFromArticle(_ value: Favorite)

    @objc(addArticle:)
    @NSManaged public func addToArticle(_ values: NSSet)

    @objc(removeArticle:)
    @NSManaged public func removeFromArticle(_ values: NSSet)

}

extension Origin : Identifiable {}

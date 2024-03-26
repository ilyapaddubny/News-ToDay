//
//  Favorite+CoreDataProperties.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 26.03.2024.
//
//

import Foundation
import CoreData

@objc(Favorite)
public class Favorite: NSManagedObject {}


extension Favorite {

//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
//        return NSFetchRequest<Favorite>(entityName: "Favorite")
//    }

    @NSManaged public var title: String?
    @NSManaged public var newsDescription: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var content: String?

}

extension Favorite: Identifiable {}

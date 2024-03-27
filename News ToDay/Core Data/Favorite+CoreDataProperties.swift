//
//  Favorite+CoreDataProperties.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 27.03.2024.
//
//

import Foundation
import CoreData

@objc(Favorite)
public class Favorite: NSManagedObject {}

extension Favorite {

    @NSManaged public var content: String?
    @NSManaged public var newsDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var author: String?
    @NSManaged public var source: Origin?

}

extension Favorite : Identifiable {

}

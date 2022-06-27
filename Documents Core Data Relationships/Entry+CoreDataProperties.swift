//
//  Entry+CoreDataProperties.swift
//  Documents Core Data Relationships
//
//  Created by Raphael Hutchins on 12/11/20.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var content: String?
    @NSManaged public var name: String?
    @NSManaged public var rawDate: Date?
    @NSManaged public var image: Data?
    @NSManaged public var category: Trip?

}

extension Entry : Identifiable {

}

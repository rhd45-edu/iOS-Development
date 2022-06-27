//
//  Document+CoreDataProperties.swift
//  Documents Core Data Relationships
//
//  Created by Raphael Hutchins on 9/30/20.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var name: String?
    @NSManaged public var content: String?
    @NSManaged public var rawImage: NSData?
    @NSManaged public var rawDate: Date?
    @NSManaged public var category: Category?

}

extension Document : Identifiable {

}

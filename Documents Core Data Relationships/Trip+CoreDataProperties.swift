//
//  Trip+CoreDataProperties.swift
//  Documents Core Data Relationships
//
//  Created by Raphael Hutchins on 12/11/20.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var title: String?
    @NSManaged public var rawDocuments: NSOrderedSet?

}

// MARK: Generated accessors for rawDocuments
extension Trip {

    @objc(insertObject:inRawDocumentsAtIndex:)
    @NSManaged public func insertIntoRawDocuments(_ value: Entry, at idx: Int)

    @objc(removeObjectFromRawDocumentsAtIndex:)
    @NSManaged public func removeFromRawDocuments(at idx: Int)

    @objc(insertRawDocuments:atIndexes:)
    @NSManaged public func insertIntoRawDocuments(_ values: [Entry], at indexes: NSIndexSet)

    @objc(removeRawDocumentsAtIndexes:)
    @NSManaged public func removeFromRawDocuments(at indexes: NSIndexSet)

    @objc(replaceObjectInRawDocumentsAtIndex:withObject:)
    @NSManaged public func replaceRawDocuments(at idx: Int, with value: Entry)

    @objc(replaceRawDocumentsAtIndexes:withRawDocuments:)
    @NSManaged public func replaceRawDocuments(at indexes: NSIndexSet, with values: [Entry])

    @objc(addRawDocumentsObject:)
    @NSManaged public func addToRawDocuments(_ value: Entry)

    @objc(removeRawDocumentsObject:)
    @NSManaged public func removeFromRawDocuments(_ value: Entry)

    @objc(addRawDocuments:)
    @NSManaged public func addToRawDocuments(_ values: NSOrderedSet)

    @objc(removeRawDocuments:)
    @NSManaged public func removeFromRawDocuments(_ values: NSOrderedSet)

}

extension Trip : Identifiable {

}

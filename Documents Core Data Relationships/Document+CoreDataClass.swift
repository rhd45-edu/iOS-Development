//
//  Document+CoreDataClass.swift
//  Documents Core Data Relationships
//
//  Created by Raphael Hutchins on 9/30/20.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    var date: Date? {
        get{
            return rawDate as Date?
        }
        set {
            rawDate = newValue as Date?
        }
    }
    
    convenience init?(name: String?, content: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext
            else {
                return nil
            }
        
        
        self.init(entity: Document.entity(), insertInto: context)
        
        self.name = name
        self.content = content
    
        
        self.rawDate = Date(timeIntervalSinceNow: 0)
    }
    
    func updateDoc(name: String?, content: String?){
        self.name = name
        self.content = content
   
        self.rawDate = Date(timeIntervalSinceNow: 0)
    }
}

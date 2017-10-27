//
//  Article+CoreDataClass.swift
//  
//
//  Created by Dillon MATHER on 2017/10/13.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

open class Article: NSManagedObject {
    
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: NSData?
    @NSManaged public var creation_date: NSDate?
    @NSManaged public var modification_date: NSDate?
    
    override open var description: String {
        if let t = self.title {
            if let l = self.language {
                return "article : \(t) in language \(l)"
            }
            else {
                return "article : \(self.title) in language \(self.language)"
            }
        }
        else {
            return "article : \(self.title) in language \(self.language)"
        }
    }
    
}

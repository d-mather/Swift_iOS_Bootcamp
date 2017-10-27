//
//  ArticleManager.swift
//  CoreDataProject
//
//  Created by Dillon MATHER on 2017/10/13.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import Foundation
import CoreData
import UIKit

open class ArticleManager {
    
    open var managedObjectContext: NSManagedObjectContext?
    
    public init() {
        
    }
//    public init() {
//        let bundle = Bundle.init(for: dmather2017.Article)
//        let url = bundle.url(forResource: "article", withExtension: "momd")!
//        let mom = NSManagedObjectModel(contentsOf: url)
//        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
//        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//        managedObjectContext.persistentStoreCoordinator = psc
//        
//        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let docURL = urls[urls.endIndex-1]
//        let storeURL = docURL.appendingPathComponent("article.xcdatamodeld")
//        do {
//            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
//        } catch {
//            print("Error migrating store: \(error)")
//        }
//        
//    }

    open func newArticle() -> Article {
        var article: Article!
        let context = self.managedObjectContext
        context?.performAndWait {
            let ent = NSEntityDescription.entity(forEntityName: "Article", in: context!)
            article = Article(entity: ent!, insertInto: context)
        }
        return article
    }
    
//    open func getAllArticles() -> Article {
//        var array: Article!
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: self.managedObjectContext!)
//        fetchRequest.entity = entityDescription
//        do {
//            let result = try self.managedObjectContext?.fetch(fetchRequest)
//            if ((result?.count)! > 0) {
//                let result = result as? Article
//                array = result
//            }
//            else {
//                array = []
//            }
//            
//        } catch (let error) {
//            //            let fetchError = error as NSError
//            //            print(fetchError)
//            print(error)
//        }
//        return array
//    }
    
    open func removeArticle(_ article : Article) {
        let context = self.managedObjectContext
        context?.performAndWait {
            do {
                context?.delete(article)
                try context?.save()
                print("article deleted")
            } catch (let error) {
                print("Failed to delete context: \(error)")
            }
        }
    }
    
    open func save() {
        let context = self.managedObjectContext
        
        context?.performAndWait {
            do {
                try context?.save()
                print("article saved")
            } catch (let error) {
                print("Failed to save context: \(error)")
            }
        }
    }
    
}

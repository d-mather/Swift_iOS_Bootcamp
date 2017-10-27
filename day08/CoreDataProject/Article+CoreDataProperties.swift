//
//  Article+CoreDataProperties.swift
//  
//
//  Created by Dillon MATHER on 2017/10/13.
//
//  This file was automatically generated and should not be edited.
//

//import Foundation
//import CoreData
//import UIKit
//
//open class ArticleManager {
//
//    open var managedObjectContext: NSManagedObjectContext
//    
//    open func newArticle() -> Article {
//        var article: Article!
//        let context = self.managedObjectContext
//        context.performAndWait {
//            let ent = NSEntityDescription.entity(forEntityName: "Article", in: context)
//            article = Article(entity: ent!, insertInto: context)
//        }
//        return article
//    }
//    
//    open func getAllArticles() -> Article {
//        var array: Article!
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: self.managedObjectContext)
//        fetchRequest.entity = entityDescription
//        do {
//            let result = try self.managedObjectContext.fetch(fetchRequest)
//            if (result.count > 0) {
//                let result = result as! Article
//                array = result
//            }
//            else {
//                array = []
//            }
//            
//        } catch (let error) {
////            let fetchError = error as NSError
////            print(fetchError)
//            print(error)
//        }
//        return array
//    }
//    
//    open func removeArticle(_ article : Article) {
//        let context = self.managedObjectContext
//        context.performAndWait {
//            do {
//                context.delete(article)
//                try context.save()
//                print("article deleted")
//            } catch (let error) {
//                print("Failed to delete context: \(error)")
//            }
//        }
//    }
//
//    open func save() {
//        let context = self.managedObjectContext
//        
//        context.performAndWait {
//            do {
//                try context.save()
//                print("article saved")
//            } catch (let error) {
//                print("Failed to save context: \(error)")
//            }
//        }
//    }
//    
//}

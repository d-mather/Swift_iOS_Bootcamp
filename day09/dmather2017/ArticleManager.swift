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

//open class ArticleManager {
//    
//    open var managedObjectContext: NSManagedObjectContext?
//
//    public init() {
//        let bundle = Bundle.init(for: dmather2017.Article)
//        if bundle == nil {
//            print("Reached 1")
//        }
//        if bundle.url(forResource: "article", withExtension: "momd")
//        {
//            print("Reached 2")
//        let mom = NSManagedObjectModel(contentsOf: url)
//        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
//        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//            managedObjectContext?.persistentStoreCoordinator = psc
//        
//        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let docURL = urls[urls.endIndex-1]
//        let storeURL = docURL.appendingPathComponent("article.xcdatamodeld")
//        do {
//            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
//            } catch {
//            print("Error migrating store: \(error)")
//            }
//        }
//        
//    }
//
//    open func newArticle() -> Article {
//        var article: Article!
//        let context = self.managedObjectContext
//        context?.performAndWait {
//            let ent = NSEntityDescription.entity(forEntityName: "Article", in: context!)
//            article = Article(entity: ent!, insertInto: context)
//        }
//        return article
//    }
//    
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
//            
//        } catch (let error) {
//            //            let fetchError = error as NSError
//            //            print(fetchError)
//            print(error)
//        }
//        return array
//    }
//    
//    open func getArticles(withLang lang:String) -> [Article] {
//        var array: [Article]!
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: self.managedObjectContext!)
//        fetchRequest.entity = entityDescription
//        fetchRequest.predicate = NSPredicate(format: "language == %@", lang)
//        do {
//            let result = try self.managedObjectContext?.fetch(fetchRequest)
//            if ((result?.count)! > 0) {
//                let result = result as! [Article]
//                array = result
//            }
//            else {
//                array = []
//            }
//            
//        } catch {
//            let fetchError = error as NSError
//            print(fetchError)
//        }
//        return array
//    }
//    
//    open func getArticles(containString str: String) -> [Article] {
//        var array: [Article]!
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: self.managedObjectContext!)
//        fetchRequest.entity = entityDescription
//        fetchRequest.predicate = NSPredicate(format: "title contains %@ || content contains %@", str, str)
//        do {
//            let result = try self.managedObjectContext?.fetch(fetchRequest)
//            if ((result?.count)! > 0) {
//                let result = result as! [Article]
//                array = result
//            }
//            else {
//                array = []
//            }
//            
//        } catch {
//            let fetchError = error as NSError
//            print(fetchError)
//        }
//        return array
//    }
//    
//    open func removeArticle(_ article : Article) {
//        let context = self.managedObjectContext
//        context?.performAndWait {
//            do {
//                context?.delete(article)
//                try context?.save()
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
//        context?.performAndWait {
//            do {
//                try context?.save()
//                print("article saved")
//            } catch (let error) {
//                print("Failed to save context: \(error)")
//            }
//        }
//    }
//    
//}

open class ArticleManager {
    
    open var managedObjectContext : NSManagedObjectContext;
    
    
    public init () {
        
        /* Reference To Pod */
        var model_url : URL!;
        
        /* Error Habndeling */
        var preError : String = "{-} Error ::";
        
        if let bundle_url = Bundle(for: Article.self).url(forResource: "phjacobs2017", withExtension: "bundle")
        {
            guard let framework_bundle = Bundle(url : bundle_url) else
            {
                fatalError("Bundle Couldn't Load");
                
            }
            model_url = framework_bundle.url(forResource: "Article", withExtension: "momd");
        }
        else
        {
            model_url = Bundle(for: Article.self).url(forResource: "Article", withExtension: "momd");
        }
        
        guard let momdModel = NSManagedObjectModel(contentsOf: model_url) else
        {
            fatalError("Momd Model initializing from url failed");
        }
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: momdModel)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
        
        let qosClass = DispatchQoS.QoSClass.background;
        let queue = DispatchQueue.global(qos: qosClass);
        
        /* Run background thread */
        queue.async
            {
                let urls = FileManager.default.urls(for:  FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask)
                let docURL = urls[urls.endIndex-1]
                let storeURL = docURL.appendingPathComponent("phjacobs2017.sqlite", isDirectory: true)
                do
                {
                    try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                    print("Success!");
                } catch {
                    fatalError("Error migrating store: \(error)");
                }
        }
    }
    
    /* CREATE ARTICLE */
    open func newArticle() -> Article {
        print("newArticle() --- created!")
        return (NSEntityDescription.insertNewObject(forEntityName: "Article", into: self.managedObjectContext) as! Article);
    }
    
    /* FETCH ALL ARTICLES */
    open func getAllArticles() -> [Article] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        do {
            let result = try managedObjectContext.fetch(request) as! [Article];
            return result
        } catch{
            return []
        }
    }
    
    /* GET ARTICLE WITH LANGUAGE AS KEY */
    open func  getArticles(withLang lang : String) -> [Article] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.predicate = NSPredicate(format: "language == %@", lang)
        do
        {
            let result = try managedObjectContext.fetch(request) as! [Article];
            return (result);
        }
        catch
        {
            return [];
        }
    }
    
    /* GET ARTICLE CONTAINING GIVEN STRING */
    open func getArticles(containString str : String) -> [Article] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.predicate = NSPredicate(format: "title CONTAINS %@ || content CONTAINS %@", str,str)
        
        do{
            let result = try managedObjectContext.fetch(request) as! [Article]
            return result
        } catch {
            return []
        }
    }
    
    /* REMOVE ARICLE WITH OBJ AS KEY */
    open func removeArticle(article : Article) {
        managedObjectContext.delete(article)
    }
    
    /* SAVE ALL MODIFICATIONS */
    open func save()
    {
        if managedObjectContext.hasChanges
        {
            do
            {
                try managedObjectContext.save()
            }
            catch
            {
                fatalError("{-}Failure to save content \(error)");
            }
        }
    }
    
    func ArticleManagerError(_errorCase_ : String) {
        var preError : String = "{-} Error [\(_errorCase_)] ::";
        var postError : String = "Try rebuilding the application or email contact the primary developer @phjacobs";
        
        switch _errorCase_ {
        case "Bundle":
            fatalError("\(preError) Bundle Couldn't Load");
        case "Momd Model":
            fatalError("\(preError) initializing from url failed");
        default:
            fatalError("\(preError)\n\(postError)");
        }
    }
}

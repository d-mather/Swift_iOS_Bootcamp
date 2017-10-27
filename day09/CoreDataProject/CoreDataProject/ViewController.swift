//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Dillon MATHER on 2017/10/13.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import UIKit
import dmather2017
import CoreData

class ViewController: UIViewController {
    
//    let articleManager = ArticleManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//
////        let art1 = articleManager.newArticle()
////        art1.title = "First Article"
////        art1.content = "there is content here ;)"
////        art1.language = "en"
////        let art2 = articleManager.newArticle()
////        art2.title = "Second Article"
////        art2.content = "There is even more and better content here ;D"
////        art2.language = "en"
////        articleManager.save()
//        
////        let frart = articleManager.getArticles(withLang: "en")
////        print("fr article")
////        print(frart)
////        print("\n\n")
////        let art1bis = articleManager.getArticles(containString: "article 1")
////        print("contain with string")
////        print(art1bis)
////        print("\n\n")
////        print("allArticle")
////        let ret = articleManager.getAllArticles()
////        for article in ret {
////            print(article)
////        }
////        print("\n\n")
////        print("remove First Article: ")
////        articleManager.removeArticle(ret.first!)
////        let ret2 = articleManager.getAllArticles()
////        for now in ret2 {
////            print(now)
////        }
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    /* Article Manager */
    let InstanceArticleManager : ArticleManager = ArticleManager();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
//        /* Create Articles */
//                let article_id_1 : Article = InstanceArticleManager.newArticle();
//                let article_id_2 : Article = InstanceArticleManager.newArticle();
//                let article_id_3 : Article = InstanceArticleManager.newArticle();
//        //        let article_id_4 : Article = InstanceArticleManager.newArticle();
//        
//        
//                article_id_1.title              = "Zuma won't resign!"
//                article_id_1.content            = "Zuma says that he earned his spot. Why should he step down for those that didn't."
//                article_id_1.creation_date      = NSDate();
//                article_id_1.modification_date  = NSDate();
//                article_id_1.language           = "en";
//        
//                article_id_2.title              = "2 Zuma won't resign!"
//                article_id_2.content            = "2 Zuma says that he earned his spot. Why should he step down for those that didn't."
//                article_id_2.creation_date      = NSDate();
//                article_id_2.modification_date  = NSDate();
//                article_id_2.language           = "en";
//        
//        
//                article_id_3.title              = "3 Zuma won't resign!"
//                article_id_3.content            = "3 Zuma says that he earned his spot. Why should he step down for those that didn't."
//                article_id_3.creation_date      = NSDate();
//                article_id_3.modification_date  = NSDate();
//                article_id_3.language           = "en";
//                /* Save All Modifications That's Been Done */
//                InstanceArticleManager.save();
//        
//        let printArr = InstanceArticleManager.getAllArticles();
//        
//        for el in printArr{
//            print ("Elem : \(el.title) ");
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


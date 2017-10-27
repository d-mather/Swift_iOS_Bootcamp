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
    
    let articleManager = ArticleManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let art1 = articleManager.newArticle()
        art1.title = "First Article"
        art1.content = "there is content here ;)"
        art1.language = "en"
        let art2 = articleManager.newArticle()
        art2.title = "Second Article"
        art2.content = "There is even more and better content here ;D"
        art2.language = "en"
        articleManager.save()
        
        let frart = articleManager.getArticles(withLang: "en")
        print("fr article")
        print(frart)
        print("\n\n")
        let art1bis = articleManager.getArticles(containString: "article 1")
        print("contain with string")
        print(art1bis)
        print("\n\n")
        print("allArticle")
        let ret = articleManager.getAllArticles()
        for article in ret {
            print(article)
        }
        print("\n\n")
        print("remove First Article: ")
        articleManager.removeArticle(ret.first!)
        let ret2 = articleManager.getAllArticles()
        for now in ret2 {
            print(now)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


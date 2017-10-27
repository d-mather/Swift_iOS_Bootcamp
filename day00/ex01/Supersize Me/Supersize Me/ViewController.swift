//
//  ViewController.swift
//  Supersize Me
//
//  Created by Dillon MATHER on 2017/10/02.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func button(_ sender: UIButton){
        if label.text == "Hello" {
            label.text = "World"
        } else {
            label.text = "Hello"
        }
//        _ = sender.title(for: .normal)!
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}


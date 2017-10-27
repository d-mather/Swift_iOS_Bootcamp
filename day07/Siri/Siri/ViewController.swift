//
//  ViewController.swift
//  Siri
//
//  Created by Dillon MATHER on 2017/10/12.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import UIKit
import RecastAI

class ViewController: UIViewController {
    
    var bot : RecastAIClient?

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    
    @IBAction func SendButton(_ sender: UIButton) {
//        myLabel.text = myTextField.text
        makeRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bot = RecastAIClient(token : "4eeab950f0cbc7d5d23f1bf1f94d1ff2")
        self.bot = RecastAIClient(token : "4eeab950f0cbc7d5d23f1bf1f94d1ff2", language: "en")
    }
    
    func makeRequest()
    {
        //Call makeRequest with string parameter to make a text request
        let str = myTextField.text
        self.bot?.textRequest(str!, successHandler: { (Response) in
            self.myLabel.text = Response.intent()?.slug
            self.myTextField.text = ""
            print(Response)
        }, failureHandle: { (Error) in
            self.err()
        })
    }
    
//    func makeRequest()
//    {
//        //Call makeRequest with string parameter to make a converse request
//        var str = myTextField.text
//        self.bot?.textConverse(str,
//                               successHandler: { (Response) in
//                                    Response.
//                                }, failureHandle: { (Error) in
//                                    <#code#>
//                                })
//    }

    func err() {
        myLabel.text = "Error"
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }


}


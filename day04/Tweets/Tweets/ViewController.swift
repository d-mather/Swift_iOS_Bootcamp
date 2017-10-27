//
//  ViewController.swift
//  Tweets
//
//  Created by Dillon MATHER on 2017/10/07.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Importing objects
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!

    var tweets:[String] = []
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

//    let utf_eight_str = "8nLe8lG6TKCj1yuYvaIaWvoAc:GXlyxTMmBCNBRRCBMOAYrY4P91DA2cT4DyixGogHN9YwENrKfY".data(using: String.Encoding.utf8)
//    let BEARER = utf_eight_str?.base64EncodedStringWithOptions(NSData.Base64EncodingOptions(rawValue: 0))
    
//    func toBase64() -> String {
//        return Data(utf_eight_str).base64EncodedString()
//    }
    
    // activity indicator
    var  activityIndicator = UIActivityIndicatorView()
    
    func startA() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    // setting up table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myTableViewCell
        cell.myTextView.text = tweets[indexPath.row]
        return cell
    }
    
    @IBAction func serach(_ sender: UIButton) {
        if myTextField.text != "" {
            startA()
            let user = myTextField.text?.replacingOccurrences(of: " ", with: "")
            getStuff(user: user!)
        }
    }
    
    // creating function that gets all of the stuff
    func getStuff(user:String) {
        let url = URL(string: "https://twitter.com/" + user)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    if let errorMessage = error?.localizedDescription {
                        self.myLabel.text = errorMessage
                    } else {
                        self.myLabel.text = "There has been an error. Try again."
                    }
                }
            } else {
                let webContent:String = String(data: data!, encoding: String.Encoding.utf8)!
                
                if webContent.contains("<title>") && webContent.contains("data-resolved-url-large=\"") {
                    
                    // get the name
                    var array:[String] = webContent.components(separatedBy: "<title>")
                    array = array[1].components(separatedBy: " |")
                    let name = array[0]
                    array.removeAll()
                    
                    // get the profile picture
                    array = webContent.components(separatedBy: "data-resolved-url-large=\"")
                    array = array[1].components(separatedBy: "\"")
                    let profilePicture = array[0]
                    print(profilePicture)
                    
                    // get the tweets
                    array = webContent.components(separatedBy: "data-aria-label-part=\"0\">") + webContent.components(separatedBy: "data-aria-label-part=\"4\">")
                    array.remove(at: 0)
                    
                    for i in 0...array.count-1 {
                        let newTweet = array[i].components(separatedBy: "<")
                        array[i] = newTweet[0]
                    }
                    
                    self.tweets = array.filter {$0 != ""}
                    
                    DispatchQueue.main.async {
                        self.myLabel.text = name
                        self.updateImage(url: profilePicture)
                        self.myTableView.reloadData()
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }
                
                } else {
                    DispatchQueue.main.async {
                        self.myLabel.text = "Sorry, we couldn't find that user"
                        self.tweets = []
                        self.myTableView.reloadData()
                        self.myImageView.image = nil
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }
                }
            }
        }
        task.resume()
    }
    
    // function that gets profilePicture data
    func updateImage(url: String) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async {
                self.myImageView.image = UIImage(data: data!)
            }
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        func getTweets(token : String, q : String) {
            
            let url : NSURL = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?" + q)!
            let request = NSMutableURLRequest(url: url as URL)
            
            request.httpMethod = "GET"
            request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
            request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {// gets run in async thread, when server responds.
                (data, response, error) in

                if let err = error {
                    print(err)
                }
                else if let d = data {
                    do {
                        if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                            print("#-----------------------------------------------------------------------#")
                            print(dic)
//                            print("#-----------------------------------------------------------------------#")
                        }
                    }
                    catch (let err) {
                        print(err)
                    }
                }
            }
            task.resume()
        }
        
        
        let BEARER = (("8nLe8lG6TKCj1yuYvaIaWvoAc:GXlyxTMmBCNBRRCBMOAYrY4P91DA2cT4DyixGogHN9YwENrKfY").data(using: String.Encoding.utf8))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        let url : NSURL = NSURL(string: "https://api.twitter.com/oauth2/token")!
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {// gets run in async thread, when server responds.
            (data, response, error) in
//            if let resp = response {
//                //print(resp)
//            }
            
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        //print(dic)
                        if (dic.value(forKey: "token_type") as! String == "bearer") {
                            getTweets(token: dic.value(forKey: "access_token") as! String, q: "q=%40twitterapi&count=4")
//                            print("$-----------------------------------------------------------------------$")
//                            print(dic)
//                            print("$-----------------------------------------------------------------------$")
                        }
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
        
        //        PlaygroundPage.current.needsIndefiniteExecution = true
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


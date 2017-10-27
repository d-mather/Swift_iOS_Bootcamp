//
//  ViewController.swift
//  APM
//
//  Created by Dillon MATHER on 2017/10/06.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var myCollectoinView: UICollectionView!
    let array:[String] = ["space1", "space2", "space3", "space4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let itemSize = UIScreen.main.bounds.width/2 - 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        myCollectoinView.collectionViewLayout = layout
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        createAlert(title: "ERROR", message: "There was an error with a picture")
    }
    
    //alert func
    func createAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
        alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        var path = paths[0] as String;
        path = path + array[indexPath.row] + ".jpg"
        if(FileManager.default.fileExists(atPath: path)) {
            createAlert(title: "ERROR", message: "There was an error with a picture")
        }
        
        cell.myImageView.image = UIImage(named: array[indexPath.row] + ".jpg")
        return cell
    }

}


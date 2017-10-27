//
//  CreateObject.swift
//  MotionCube
//
//  Created by Dillon MATHER on 2017/10/11.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import Foundation
import UIKit

class CreateObject: UIView {
    
    var height: CGFloat = 100
    var width: CGFloat = 100
    var color: UIColor?
    var form: String?
    
    init(x: CGFloat, y: CGFloat) {
        let rdm = Int(arc4random_uniform(2))
        switch rdm {
        case 0:
            self.form = "circle"
        default:
            self.form = "square"
        }
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        self.color = UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
        super.init(frame: CGRect(x: x - self.width/2, y: y - self.height/2, width: self.width, height: self.height))
        self.backgroundColor = self.color
        if self.form == "circle" {
            self.layer.cornerRadius = self.frame.size.width / 2
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

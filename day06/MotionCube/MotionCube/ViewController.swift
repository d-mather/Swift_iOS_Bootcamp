//
//  ViewController.swift
//  MotionCube
//
//  Created by Dillon MATHER on 2017/10/11.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var itemBehaviour: UIDynamicItemBehavior!
    var attachment: UIAttachmentBehavior!

    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        print("tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:)))
        view.addGestureRecognizer(tapGesture)
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        itemBehaviour = UIDynamicItemBehavior()
        itemBehaviour.elasticity = 0.3
        gravity.magnitude = 1.0
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
        animator.addBehavior(itemBehaviour)
    }

    func tapGestureHandler(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            let obj = CreateObject.init(x: gesture.location(in: view).x, y: gesture.location(in: view).y)
            animator.addBehavior(collision)
            animator.addBehavior(gravity)
            view.addSubview(obj)
            gravity.addItem(obj)
            collision.addItem(obj)
            itemBehaviour.addItem(obj)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


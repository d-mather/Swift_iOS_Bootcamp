//
//  ViewController.swift
//  Moar Buttons
//
//  Created by Dillon MATHER on 2017/10/02.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen:Double = 0;
    var previousNumber:Double = 0;
    var performingMath = false;
    var operation = 0;

    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        if performingMath == true {
            print(String(sender.tag-1));
            label.text = String(sender.tag-1)
            numberOnScreen = Double(label.text!)!
            performingMath = false
        } else {
            if label.text == "0" {
                label.text = "";
            }
            print(String(sender.tag-1));
            label.text = label.text! + String(sender.tag-1)
            numberOnScreen = Double(label.text!)!
        }
    }
    
    @IBAction func button(_ sender: UIButton) {
        if sender.tag == 17 && label.text != "+" && label.text != "-" && label.text != "x" && label.text != "/" {
            print("NEG");
            label.text = String(Double(label.text!)! * -1)
            numberOnScreen = Double(label.text!)!
        }
        else if label.text != "" && sender.tag != 11 && sender.tag != 16 && performingMath == false {
            previousNumber = Double(label.text!)!
            if sender.tag == 12 { // divide
                label.text = "/"
                print("/");
            } else if sender.tag == 13 { // multiply
                label.text = "x"
                print("x");
            } else if sender.tag == 14 { // minus
                label.text = "-"
                print("-");
            } else if sender.tag == 15 { // plus
                label.text = "+"
                print("+");
            }
            operation = sender.tag
            performingMath = true;
        }
        else if sender.tag == 16 {
            print("=");
            //previousNumber = Double(label.text!)!
            if operation == 12 {
                label.text = String(previousNumber / numberOnScreen)
            }
            else if operation == 13 {
                label.text = String(previousNumber * numberOnScreen)
            }
            else if operation == 14 {
                print(String(previousNumber - numberOnScreen));
                label.text = String(previousNumber - numberOnScreen)
            }
            else if operation == 15 {
                label.text = String(previousNumber + numberOnScreen)
            }
        }
        else if sender.tag == 11 {
            print("AC");
            label.text = "0";
            previousNumber = 0;
            numberOnScreen = 0;
            operation = 0;
            performingMath = false;
        }
    }
    
    @IBAction func flip(_ sender: UIButton) {
        print("Flip");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


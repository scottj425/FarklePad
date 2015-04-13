//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class userView: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate {
    @IBOutlet weak var playerStepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var playerNames: Array<UITextField>!
    @IBOutlet weak var xbutton: UIButton!
    @IBOutlet var playerLabels: Array<UILabel>!
    var labelCount:Int = 0

    override func viewDidLoad() {
            
            startButton.layer.borderWidth = 0.5
            startButton.layer.borderColor = startButton.titleColorForState(UIControlState.Normal)?.CGColor
            startButton.layer.cornerRadius = 10
            startButton.clipsToBounds = true
            self.view.backgroundColor = UIColor.clearColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        for tb in playerNames {
            tb.delegate = self
        }
        let prefs = NSUserDefaults.standardUserDefaults()
        let fullversion = prefs.valueForKey("fullversion") as Bool
        if !fullversion {
            
            for var i = 2; i < playerNames.count; i++ {
                playerNames[i].placeholder = "Requires Upgrade"
                playerNames[i].enabled = false
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 150
    }
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 150
    }

    @IBAction func StartClick(sender: AnyObject) {
        var textEmpty: Bool = false
        //
        if (countElements(playerNames[0].text) == 0 || countElements(playerNames[1].text) == 0) {
            var alert = UIAlertController(title: "", message: "Farklepad Requires a minimum of 2 players.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        for textbox in playerNames
        {
            if textbox.enabled {
                if countElements(textbox.text) == 0 {
                    textEmpty = true
                } else {
                    if (textEmpty) {
                    var alert = UIAlertController(title: "", message: "Please do not skip players.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                    }
                }
                
            }
        }
        
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var nameArray = [String]()
        for textbox in playerNames
        {
            if countElements(textbox.text) > 0{
                
                nameArray.append(textbox.text)
                
            }
        }
        userDefaults.setObject(nameArray, forKey: "names")
        
        
        
    }
    func HideAll() {
        for var i = 2; i < 8; i++
        {
            playerLabels[i].hidden=true
            playerLabels[i].enabled=false
            playerNames[i].hidden=true
            playerNames[i].enabled=false
        }
    }
    override func viewDidLayoutSubviews() {
        
        
    }
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        
        let newLength = countElements(textField.text!) + countElements(string!) - range.length
        return newLength <= 12 //Bool
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag != 7 {
            playerNames[textField.tag + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func click(sender: UITapGestureRecognizer) {
        var touch = sender.locationInView(self.view)
        println(touch)
        for tb in playerNames {
            var maxX = tb.frame.maxX
            var minX = tb.frame.minX
            var maxY = tb.frame.maxY
            var minY = tb.frame.minY
            if (touch.x <= maxX && touch.x >= minX && touch.y <= maxY && touch.y >= minY) {
                println("TextField!")
                return
            }
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
}


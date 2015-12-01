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
    var keyboardOut = false;
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
        let fullversion = prefs.valueForKey("fullversion") as! Bool
        if !fullversion {
            
            for var i = 2; i < playerNames.count; i++ {
                playerNames[i].placeholder = "Requires Upgrade"
                playerNames[i].enabled = false
            }
        }
        print("here!")
        if ((prefs.arrayForKey("names")) != nil) {
            let names:Array = prefs.arrayForKey("names")!
            for var i=0;i<names.count;i++
            {
                print(names[i] as! NSString)
                playerNames[i].text = String(names[i] as! NSString)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    func keyboardWillShow(sender: NSNotification) {
        if (!keyboardOut) {
            keyboardOut = true
            self.view.frame.origin.y -= 150
        }
    }
    func keyboardWillHide(sender: NSNotification) {
        
        self.view.frame.origin.y += 150
        keyboardOut = false;
    }

    @IBAction func StartClick(sender: AnyObject) {
        var textEmpty: Bool = false
        //
        if (playerNames[0].text?.characters.count == 0 || playerNames[1].text?.characters.count == 0) {
            var alert = UIAlertController(title: "", message: "Farklepad Requires a minimum of 2 players.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        for textbox in playerNames
        {
            if textbox.enabled {
                if textbox.text?.characters.count == 0 {
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
            if textbox.text?.characters.count > 0{
                
                nameArray.append(textbox.text!)
                
            }
        }
        userDefaults.setObject(nameArray, forKey: "names")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("GameBoard") as UIViewController!
        self.presentViewController(vc, animated: false, completion: nil)
        
        
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
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let newLength = textField.text!.characters.count + string.characters.count - range.length
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
        let touch = sender.locationInView(self.view)
        print(touch)
        for tb in playerNames {
            let maxX = tb.frame.maxX
            let minX = tb.frame.minX
            let maxY = tb.frame.maxY
            let minY = tb.frame.minY
            if (touch.x <= maxX && touch.x >= minX && touch.y <= maxY && touch.y >= minY) {
                print("TextField!")
                return
            }
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
}


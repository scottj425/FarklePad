//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class StartGameView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var playerStepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var playerNames: Array<UITextField>!
    @IBOutlet var playerLabels: Array<UILabel>!
    var labelCount:Int = 0
    var yCount:CGFloat = 101
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playerStepper.minimumValue = 2
        playerStepper.maximumValue = 8
        playerStepper.autorepeat = true
        HideAll()
        for tb in playerNames {
            tb.delegate = self
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func StepperClick(sender: AnyObject) {
        countLabel.text = String(format:"%.f", playerStepper.value)
        HideAll()
        for var i = 2; i < Int(playerStepper.value); i++
        {
            playerLabels[i].hidden=false
            playerLabels[i].enabled=true
            playerNames[i].hidden=false
            playerNames[i].enabled=true
            
        }
        yCount = playerNames[Int(playerStepper.value) - 1].center.y
        startButton.center.y = yCount
        
        
    }
    @IBAction func StartClick(sender: AnyObject) {
        for textbox in playerNames
        {
            if textbox.enabled {
                if countElements(textbox.text) == 0 {
                    var alert = UIAlertController(title: "Alert", message: "Each player must have a name.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    break
                }
                
            }
        }

        
        let userDefaults = NSUserDefaults.standardUserDefaults()
            var nameArray = [String]()
        for textbox in playerNames
        {
            if textbox.enabled {
                
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
        startButton.center.y = yCount + 40
        
    }
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        
        let newLength = countElements(textField.text!) + countElements(string!) - range.length
        return newLength <= 12 //Bool
        
    }
   
}


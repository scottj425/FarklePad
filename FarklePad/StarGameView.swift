//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class StartGameView: UIViewController {
    @IBOutlet weak var playerStepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var playerNames: Array<UITextField>!
    @IBOutlet var playerLabels: Array<UILabel>!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playerStepper.minimumValue = 2
        playerStepper.maximumValue = 8
        playerStepper.autorepeat = true
        HideAll()
        
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
        
        
    }
    @IBAction func StartClick(sender: AnyObject) {
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
   
}


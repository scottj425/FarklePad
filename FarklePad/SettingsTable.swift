//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class SettingsTable: UITableViewController {

   
    @IBOutlet weak var colorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if ((userDefaults.objectForKey("dicecolor")) == nil) {
            userDefaults.setValue("Black", forKey: "dicecolor")
        }
        colorLabel.text = (userDefaults.objectForKey("dicecolor") as String)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateColorLabel:", name: "diceColorChange", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateColorLabel(notification: NSNotification) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if ((userDefaults.objectForKey("dicecolor")) == nil) {
            userDefaults.setValue("Black", forKey: "dicecolor")
        }
        colorLabel.text = (userDefaults.objectForKey("dicecolor") as String)
    }

}


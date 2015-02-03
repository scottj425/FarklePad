//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class SettingsTable: UITableViewController {

   
    @IBOutlet var winLabel: UILabel!
    @IBOutlet var farkleLabel: UILabel!
    @IBOutlet var threshLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if ((userDefaults.objectForKey("dicecolor")) == nil) {
            userDefaults.setValue("Black", forKey: "dicecolor")
        }
        if ((userDefaults.objectForKey("threshold")) == nil) {
            userDefaults.setValue("500", forKey: "threshold")
        }
        if ((userDefaults.objectForKey("winthreshold")) == nil) {
            userDefaults.setValue("10000", forKey: "winthreshold")
        }
        if ((userDefaults.objectForKey("farkle")) == nil) {
            userDefaults.setValue("-500", forKey: "farkle")
        }
        colorLabel.text = (userDefaults.objectForKey("dicecolor") as String)
        threshLabel.text = (userDefaults.objectForKey("threshold") as String)
        winLabel.text = (userDefaults.objectForKey("winthreshold") as String)
        farkleLabel.text = (userDefaults.objectForKey("farkle") as String)
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
        if ((userDefaults.objectForKey("threshold")) == nil) {
            userDefaults.setValue("500", forKey: "threshold")
        }
        if ((userDefaults.objectForKey("farkle")) == nil) {
            userDefaults.setValue("-500", forKey: "farkle")
        }
        colorLabel.text = (userDefaults.objectForKey("dicecolor") as String)
        threshLabel.text = (userDefaults.objectForKey("threshold") as String)
       farkleLabel.text = (userDefaults.objectForKey("farkle") as String)
        winLabel.text = (userDefaults.objectForKey("winthreshold") as String)

    }

}


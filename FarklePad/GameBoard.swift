//
//  GameBoard.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class GameBoard: UIViewController {
    
    @IBOutlet var effectview: UIVisualEffectView!
    @IBOutlet var background: UIImageView!
    @IBOutlet var diceImage: UIImageView!
    @IBOutlet weak var turnScore: UILabel!
    @IBOutlet weak var rollLabel: UILabel!
    @IBOutlet var playerButtons: Array<UIButton>!
    @IBOutlet var scoreLabels: Array<UILabel>!
    override func viewDidLoad() { 
        super.viewDidLoad()
         let userDefaults = NSUserDefaults.standardUserDefaults()
        let names:Array = userDefaults.arrayForKey("names")!
        for var i=0;i<names.count;i++
        {
            playerButtons[i].setTitle(String(names[i] as NSString), forState: UIControlState.Normal)
            playerButtons[i].hidden=false
        }
        playerButtons[0].setTitleColor(UIColor.yellowColor(), forState: .Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func click(sender: UIButton) {
        var text = sender.currentTitle
        var start = text?.rangeOfString(" = ")?.endIndex
        var amount = text?.substringFromIndex(start!).toInt()
        var prevamount = turnScore.text?.toInt()
        var total = amount! + prevamount!
        turnScore.text = String(total)
        var rollcount = rollLabel.text!.toInt()! + 1
        rollLabel.text = String(rollcount)
        
    }

    
    
}
//
//  GameBoard.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class GameBoard: UIViewController {
    var playStatus = [0,0,0,0,0,0,0]
    @IBOutlet var effectview: UIVisualEffectView!
    @IBOutlet var background: UIImageView!
    @IBOutlet var diceImage: UIImageView!
    @IBOutlet weak var turnScore: UILabel!
    @IBOutlet var threshold: UILabel!
    @IBOutlet var farkleLabel: UILabel!
    @IBOutlet var playerButtons: Array<UIButton>!
    @IBOutlet var scoreLabels: Array<UILabel>!
    @IBOutlet var farkleLabels: Array<UILabel>!
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
        //Check for dice color
        if ((userDefaults.objectForKey("dicecolor")) == nil) {
            userDefaults.setValue("Black", forKey: "dicecolor")
        }
        switch userDefaults.objectForKey("dicecolor") as String {
        case "Black":
            diceImage.image = UIImage(named: "dice_black.png")
        case "Blue":
            diceImage.image = UIImage(named: "dice_light-blue.png")
        case "Purple":
            diceImage.image = UIImage(named: "dice_pink.png")
        case "Tan":
            diceImage.image = UIImage(named: "dice_kacki.png")
        default:
            diceImage.image = UIImage(named: "dice_black.png")
        }

                //Set threshold
        if ((userDefaults.objectForKey("threshold")) == nil) {
            userDefaults.setValue("500", forKey: "threshold")
        }
        let thresh = userDefaults.objectForKey("threshold") as String
        threshold.text = "Start Threshold = \(thresh)"
        //Set farkle
        if ((userDefaults.objectForKey("farkle")) == nil) {
            userDefaults.setValue("-500", forKey: "farkle")
        }
        let farkle = userDefaults.objectForKey("farkle") as String
        farkleLabel.text = "Farkle = \(farkle)"
        
        
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
 
        
    }

    @IBAction func bankClick(sender: AnyObject) {
        var bIndex = 0
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let names:Array = userDefaults.arrayForKey("names")!
        for var i=0;i<names.count;i++
        {
            if (playerButtons[i].titleColorForState(.Normal) == UIColor.yellowColor())
            {
                bIndex = i
                break
            }
        }
        let startLabel = bIndex * 12
        let endLabel = startLabel + 12
        var currentLabel = endLabel
        
        for var i=startLabel;i<endLabel;i++
        {
            if (scoreLabels[i].text == "")
            {
               
                
                currentLabel = i
                break
            }
        }
        let cThresh = checkThreshold(startLabel, eLabel: endLabel, curLabel: currentLabel, bIndex: bIndex)
        if (cThresh == 1) {
            nextPlayer(bIndex, nCount: names.count)
            return
        } else if (cThresh == 2) {
            return
        }
        
        if (currentLabel > startLabel && currentLabel < endLabel)
        {
            let prevScore = scoreLabels[currentLabel - 1].text?.toInt()
            var curScore =  prevScore! + turnScore.text!.toInt()!
            if (turnScore.text!.toInt()! == 0) {
                if (farkleLabels[bIndex].text == "••") {
                    var text = farkleLabel.text
                    var start = text?.rangeOfString(" = ")?.endIndex
                    var amount = text?.substringFromIndex(start!).toInt()
                    curScore = prevScore! + amount!
                    farkleLabels[bIndex].text=""
                } else {
                    farkleLabels[bIndex].text = farkleLabels[bIndex].text! + "•"
                }
                
            }
            scoreLabels[currentLabel].text = String(curScore)
            
        } else if (currentLabel == startLabel) {
            
            var curScore = turnScore.text?.toInt()
            if (turnScore.text!.toInt()! == 0) {
                if (farkleLabels[bIndex] == "••") {
                    var text = farkleLabel.text
                    var start = text?.rangeOfString(" = ")?.endIndex
                    var amount = text?.substringFromIndex(start!).toInt()
                    curScore = curScore! + amount!
                    farkleLabels[bIndex].text=""
                } else {
                    farkleLabels[bIndex].text = farkleLabels[bIndex].text! + "•"
                }
                
            }

            
            scoreLabels[currentLabel].text = "\(curScore!)"
        } else if (currentLabel == endLabel) {
            let prevScore = scoreLabels[endLabel - 1].text?.toInt()
            var curScore =  prevScore! + turnScore.text!.toInt()!
            for var i=startLabel;i<endLabel;i++
            {
               scoreLabels[i].text = ""
            }
            if (turnScore.text!.toInt()! == 0) {
                if (farkleLabels[bIndex] == "••") {
                    var text = farkleLabel.text
                    var start = text?.rangeOfString(" = ")?.endIndex
                    var amount = text?.substringFromIndex(start!).toInt()
                    curScore = prevScore! + amount!
                    farkleLabels[bIndex].text=""
                } else {
                    farkleLabels[bIndex].text = farkleLabels[bIndex].text! + "•"
                }
                
            }

            scoreLabels[startLabel].text = "\(curScore)"
        }
        playStatus[bIndex] = 1
        nextPlayer(bIndex, nCount: names.count)
        
        }
    @IBAction func resetClick(sender: AnyObject) {
        turnScore.text = "0"
    }
    
    func checkThreshold(sLabel:Int, eLabel:Int, curLabel:Int, bIndex:Int) -> Int {

        var text = threshold.text
        var start = text?.rangeOfString(" = ")?.endIndex
        var amount = text?.substringFromIndex(start!).toInt()
        if (playStatus[bIndex] == 0 && turnScore.text?.toInt() < amount) {
            if (turnScore.text?.toInt() == 0) {
                if (curLabel == eLabel) {
                    for var i = sLabel; i < eLabel; i++ {
                        scoreLabels[i].text = ""
                    }
                    scoreLabels[sLabel].text = "0"
                    return 1
                }
                scoreLabels[curLabel].text = "0"
                
                
                return 1
            }
                var alert = UIAlertController(title: "FarklePad", message: "You must reach the starting threshold to get on the board.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                showViewController(alert, sender: self)
            
            

            return 2
        } else {
            return 3
        }
    }
    func nextPlayer(bIndex:Int,nCount:Int) {
        turnScore.text = "0"
        if (bIndex < nCount - 1) {
            playerButtons[bIndex].setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            playerButtons[bIndex+1].setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
        } else {
            playerButtons[bIndex].setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            playerButtons[0].setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
        }

    }
    
}
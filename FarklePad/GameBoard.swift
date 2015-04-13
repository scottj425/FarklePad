//
//  GameBoard.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit
import AVFoundation
import iAd
var audioPlayer = AVAudioPlayer()
var clickSound = AVAudioPlayer()
var winSound = AVAudioPlayer()
class GameBoard: UIViewController, UIPopoverPresentationControllerDelegate, ADBannerViewDelegate {
    var playStatus = [0,0,0,0,0,0,0,0]
    var thresh: String = ""
    var winAmount: String = ""
    var finalTurns: Bool = false
    var viewLoaded: Bool = false
    @IBOutlet var effectview: UIVisualEffectView!
    @IBOutlet var background: UIImageView!
    
    @IBOutlet var diceImage: UIImageView!
    @IBOutlet weak var turnScore: UILabel!
    @IBOutlet var threshold: UILabel!
    @IBOutlet var farkleLabel: UIButton!
    @IBOutlet var playerButtons: Array<UIButton>!
    @IBOutlet var scoreLabels: Array<UILabel>!
    @IBOutlet var topButtons: Array<UIButton>!
    @IBOutlet var farkleLabels: Array<UILabel>!
    override func viewDidLoad() { 
        super.viewDidLoad()
        let pref = NSUserDefaults.standardUserDefaults()
        let fullversion = pref.valueForKey("fullversion") as Bool
        if (!fullversion) {
            self.canDisplayBannerAds = true
        }
        var coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sad", ofType: "wav")!)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: coinSound, error: nil)
        audioPlayer.prepareToPlay()
        var clickSoundfile = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click", ofType: "wav")!)
        clickSound = AVAudioPlayer(contentsOfURL: clickSoundfile, error: nil)
        clickSound.prepareToPlay()
        var winSoundfile = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("winning", ofType: "wav")!)
        winSound = AVAudioPlayer(contentsOfURL: winSoundfile, error: nil)
        winSound.prepareToPlay()
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
            userDefaults.setValue("White", forKey: "dicecolor")
        }
        switch userDefaults.objectForKey("dicecolor") as String {
        case "White":
            diceImage.image = UIImage(named: "dice_white.png")
            
        case "Blue":
            diceImage.image = UIImage(named: "dice_light_blue.png")
        case "Orange":
            diceImage.image = UIImage(named: "dice_orange.png")
        case "Purple":
            diceImage.image = UIImage(named: "dice_pink.png")
        case "Tan":
            diceImage.image = UIImage(named: "dice_kacki.png")
        case "Black":
            diceImage.image = UIImage(named: "dice_black.png")
            for button in topButtons {
                
                button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                
            }
        default:
            diceImage.image = UIImage(named: "dice_white.png")
        }

                //Set threshold
        if ((userDefaults.objectForKey("threshold")) == nil) {
            userDefaults.setValue("500", forKey: "threshold")
        }
        thresh = userDefaults.objectForKey("threshold") as String
        threshold.text = "Start Threshold = \(thresh)"
        if ((userDefaults.objectForKey("winthreshold")) == nil) {
            userDefaults.setValue("10000", forKey: "winthreshold")
        }
        winAmount = userDefaults.objectForKey("winthreshold") as String
        
        //Set farkle
        if ((userDefaults.objectForKey("farkle")) == nil) {
            userDefaults.setValue("-500", forKey: "farkle")
        }
        let farkle = userDefaults.objectForKey("farkle") as String
        if ((userDefaults.objectForKey("winthreshold")) == nil) {
            userDefaults.setValue("10000", forKey: "winthreshold")
        }
        let winthresh = userDefaults.objectForKey("winthreshold") as String
        
        farkleLabel.setTitle("Farkle = \(farkle)", forState: UIControlState.Normal)
        if (userDefaults.valueForKey("customimage") != nil) {
            var custombg = userDefaults.valueForKey("customimage") as Bool
            if (custombg) {
                var imageData = userDefaults.valueForKey("background") as NSData
                background.image = UIImage(data: imageData)
            } else {
                background.image = UIImage(named: "Farkle_beach_background.png")
            }
        } else {
            background.image = UIImage(named: "Farkle_beach_background.png")
        }
        
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
        clickSound.play()
        
    }
    @IBAction func farkleclick(sender: UIButton) {
        var text = sender.currentTitle
        var start = text?.rangeOfString(" = ")?.endIndex
        var amount = text?.substringFromIndex(start!).toInt()
        turnScore.text = "0"
        audioPlayer.play()
        bankClick(self)
        clickSound.play()
        
    }


    @IBAction func bankClick(sender: AnyObject) {
        clickSound.play()
        var curScore = 0
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
        let startLabel = bIndex *  10
        let endLabel = startLabel + 10
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
            curScore =  prevScore! + turnScore.text!.toInt()!
            if (turnScore.text!.toInt()! == 0) {
                if (farkleLabels[bIndex].text == "FF") {
                    var text = farkleLabel.titleLabel?.text
                    var start = text?.rangeOfString(" = ")?.endIndex
                    var amount = text?.substringFromIndex(start!).toInt()
                    curScore = prevScore! + amount!
                    farkleLabels[bIndex].text=""
                } else {
                    farkleLabels[bIndex].text = farkleLabels[bIndex].text! + "F"
                }
                
            } else {
                farkleLabels[bIndex].text = ""
            }
            scoreLabels[currentLabel].text = String(curScore)
            
        } else if (currentLabel == startLabel) {
            
            curScore = turnScore.text!.toInt()!
            if (turnScore.text!.toInt()! == 0) {
                if (farkleLabels[bIndex].text == "FF") {
                    var text = farkleLabel.titleLabel?.text
                    var start = text?.rangeOfString(" = ")?.endIndex
                    var amount = text?.substringFromIndex(start!).toInt()
                    curScore = curScore + amount!
                    farkleLabels[bIndex].text=""
                } else {
                    farkleLabels[bIndex].text = farkleLabels[bIndex].text! + "F"
                }
                
            } else {
                farkleLabels[bIndex].text = ""
            }

            
            scoreLabels[currentLabel].text = "\(curScore)"
        } else if (currentLabel == endLabel) {
            let prevScore = scoreLabels[endLabel - 1].text?.toInt()
            curScore =  prevScore! + turnScore.text!.toInt()!
            for var i=startLabel;i<endLabel;i++
            {
               scoreLabels[i].text = ""
            }
            if (turnScore.text!.toInt()! == 0) {
                if (farkleLabels[bIndex].text == "FF") {
                    var text = farkleLabel.titleLabel?.text
                    var start = text?.rangeOfString(" = ")?.endIndex
                    var amount = text?.substringFromIndex(start!).toInt()
                    curScore = prevScore! + amount!
                    farkleLabels[bIndex].text=""
                } else {
                    println("HERE")
                    farkleLabels[bIndex].text = farkleLabels[bIndex].text! + "F"
                }
                
            } else {
                farkleLabels[bIndex].text = ""
            }

            scoreLabels[startLabel].text = "\(curScore)"
        }
        
        //win check goes here
        println("clicked")
        checkForWin(curScore, player: bIndex)
        if playStatus[bIndex] < 2 {
        playStatus[bIndex] = 1
        }
        nextPlayer(bIndex, nCount: names.count)
        
        }
    @IBAction func resetClick(sender: AnyObject) {
        clickSound.play()
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
        for var i=0;i<playerButtons.count;i++
        {
            if (playerButtons[i].titleColorForState(.Normal) == UIColor.yellowColor())
            {
                if (playStatus[i] == 2) {
                    gameOver()
                }
                break
            }
        }

    }
    override func viewDidAppear(animated: Bool) {
        var popoverContent = self.storyboard?.instantiateViewControllerWithIdentifier("PopOver") as PopOverView
        var nav = UINavigationController(rootViewController: popoverContent)
       // nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        //var popover = nav.popoverPresentationController
       // popoverContent.preferredContentSize = CGSizeMake(500,600)
        //popover?.delegate = self
        //popover?.sourceView = self.view
       // popover?.sourceRect = CGRectMake(0, 0, 500, 3000)
        
        popoverContent.titleString = "FarklePad"
        popoverContent.startThresh = thresh
        var player1 = playerButtons[0].titleLabel?.text!
        popoverContent.winAmount = winAmount
        popoverContent.player1 = player1!
        popoverContent.msgNum = 0
        if (!viewLoaded) {
        self.presentViewController(popoverContent, animated: true, completion: nil)
            viewLoaded = true
        }
    }
    func checkForWin(curValue:Int, player:Int)->Bool {
        var winValue = winAmount.toInt()
        if (curValue >= winValue) {
            for status in playStatus {
                if status == 2 {
                    return true
                }
            }
            playStatus[player] = 2
            println(playStatus)
            var popoverContent = self.storyboard?.instantiateViewControllerWithIdentifier("PopOver") as PopOverView
          //  var nav = UINavigationController(rootViewController: popoverContent)
            var name:String = playerButtons[player].titleLabel!.text!
            popoverContent.titleString = "FarklePad"
            popoverContent.winAmount = winAmount
            popoverContent.player1 = name
            popoverContent.msgNum = 1
            self.presentViewController(popoverContent, animated: true, completion: nil)
            
            
            return true
        }
        return false
    }
    func gameOver() {
        
        println("Game Over")
        var prevScore = 0
        var curLabel = 0
        println(scoreLabels.count)
        for i in 0...(scoreLabels.count - 1) {
            if let score = scoreLabels[i].text?.toInt() {
                if (score > prevScore) {
                    prevScore = score
                    curLabel = i
                }
            }
        }
         var popoverContent = self.storyboard?.instantiateViewControllerWithIdentifier("PopOver") as PopOverView
        popoverContent.titleString = "We have a winner!"
        popoverContent.winAmount = String(prevScore)
        popoverContent.player1 = playerButtons[curLabel/10].titleLabel!.text!
        popoverContent.msgNum = 2
        winSound.play()
        self.presentViewController(popoverContent, animated: true, completion: nil)
        
        
        
        
    }
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        banner.hidden=false
    }
}
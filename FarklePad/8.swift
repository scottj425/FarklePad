//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class PopOverView: UIViewController {
    var wait: Bool = true
    var titleString: String = ""
    var bgimage: UIImageView = UIImageView()
    var player1: String = ""
    var startThresh: String = ""
    var winAmount: String = ""
    var msgNum: Int = 0;
    var label: UILabel = UILabel()
    override func viewDidLoad() {
      //self.view.alpha = 0.4
      self.view.backgroundColor = UIColor.clearColor()
        let popup: UIImage = UIImage(named: "Pop-up.png")!
        bgimage = UIImageView(image: popup)
        bgimage.center = self.view.center
        self.view.addSubview(bgimage)
        label = UILabel(frame: CGRectMake(bgimage.frame.origin.x + 10, bgimage.frame.origin.y-25, bgimage.frame.size.width, 100))
        label.font = UIFont.boldSystemFontOfSize(24)
        
        label.text = titleString
        self.view.addSubview(label)
        let dismissLabel:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x + 10, bgimage.frame.origin.y+25, bgimage.frame.size.width, 500))
        dismissLabel.textAlignment = NSTextAlignment.Center
        dismissLabel.text = "- tap anywhere to dismiss -"
        dismissLabel.font = UIFont.systemFontOfSize(12)
        self.view.addSubview(dismissLabel)
        if (msgNum == 0) {
            welcomegame()
        } else if (msgNum == 1) {
            winThreshHit()
        } else if (msgNum == 2) {
            gameOver()
        }
        
        
    }

    @IBAction func tapped(sender: AnyObject) {
        if (msgNum == 2) {
            var storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var vc : ViewController = storyboard.instantiateViewControllerWithIdentifier("mainScreen") as! ViewController
            self.presentViewController(vc, animated: false, completion: nil)
            return
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    func welcomegame() {
        let Label1:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x+5, bgimage.frame.origin.y, 480, 200))
        Label1.textAlignment = NSTextAlignment.Center
        Label1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        Label1.numberOfLines = 4
        Label1.text = " Welcome to your game! You need at least \(startThresh) points to get on the board and \(winAmount) points to win. Let's play!"
        self.view.addSubview(Label1)
        let Label2:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x+5, bgimage.frame.origin.y+70, 480, 200))
        Label2.textAlignment = NSTextAlignment.Center
        Label2.text = "\(player1)'s turn"
        Label2.font = UIFont.boldSystemFontOfSize(25)
        self.view.addSubview(Label2)
    }
    func winThreshHit() {
        
        let Label1:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x+5, bgimage.frame.origin.y+80, 480, 200))
        Label1.textAlignment = NSTextAlignment.Center
        Label1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        Label1.numberOfLines = 4
        Label1.text = " Every other player will now have one chance to beat \(player1)’s high score for the win!"
        self.view.addSubview(Label1)
        let Label2:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x+5, bgimage.frame.origin.y, 480, 200))
        Label2.textAlignment = NSTextAlignment.Center
        Label2.text = player1 + " reached " + winAmount + " points!"
        Label2.font = UIFont.boldSystemFontOfSize(25)
        self.view.addSubview(Label2)

    }
    func gameOver() {
        
        let Label1:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x+5, bgimage.frame.origin.y+80, 480, 200))
        Label1.textAlignment = NSTextAlignment.Center
        Label1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        Label1.numberOfLines = 4
        Label1.text = "Congratulations \(player1)! Thank you for playing farkle with FarklePad. Your farkle game scorekeeper. Please check out other Out Of Range apps at http://www.outofrange.productions"
        self.view.addSubview(Label1)
        let Label2:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x+5, bgimage.frame.origin.y, 480, 200))
        Label2.textAlignment = NSTextAlignment.Center
        Label2.text = player1 + " won with " + winAmount + " points!"
        Label2.font = UIFont.boldSystemFontOfSize(25)
        self.view.addSubview(Label2)
        
        
    }
func waitFor (inout wait: Bool) {
        while (wait) {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode,
                beforeDate: NSDate(timeIntervalSinceNow: 0.1))
        }
    }

}


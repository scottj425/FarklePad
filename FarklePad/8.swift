//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class PopOverView: UIViewController {
    var titleString: String = ""
    var bgimage: UIImageView = UIImageView()
    var player1: String = ""
    var startThresh: String = ""
    var winAmount: String = ""
    override func viewDidLoad() {
      //self.view.alpha = 0.4
      self.view.backgroundColor = UIColor.clearColor()
        var popup: UIImage = UIImage(named: "Pop-up.png")!
        bgimage = UIImageView(image: popup)
        bgimage.center = self.view.center
        self.view.addSubview(bgimage)
        var label: UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x + 10, bgimage.frame.origin.y-25, bgimage.frame.size.width, 100))
        label.font = UIFont.boldSystemFontOfSize(24)
        
        label.text = titleString
        self.view.addSubview(label)
        var dismissLabel:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x + 10, bgimage.frame.origin.y+25, bgimage.frame.size.width, 500))
        dismissLabel.textAlignment = NSTextAlignment.Center
        dismissLabel.text = "- tap anywhere to dismiss -"
        dismissLabel.font = UIFont.systemFontOfSize(12)
        self.view.addSubview(dismissLabel)
        welcomegame()
        
        
    }

    @IBAction func tapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    func welcomegame() {
          var Label1:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x+5, bgimage.frame.origin.y, 480, 200))
        Label1.textAlignment = NSTextAlignment.Center
        Label1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        Label1.numberOfLines = 4
        Label1.text = " Welcome to your game! You need at least \(startThresh) points to get on the board and \(winAmount) points to win. Let's play!"
        self.view.addSubview(Label1)
        var Label2:UILabel = UILabel(frame: CGRectMake(bgimage.frame.origin.x+5, bgimage.frame.origin.y+70, 480, 200))
        Label2.textAlignment = NSTextAlignment.Center
        Label2.text = "\(player1)'s Turn"
        Label2.font = UIFont.boldSystemFontOfSize(25)
        self.view.addSubview(Label2)
    }
       
}


//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var clickSound:AVAudioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let pushManager = PushNotificationManager.pushManager()
        pushManager.registerForPushNotifications()
        
        let clickSoundfile = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click", ofType: "wav")!)
        clickSound = try! AVAudioPlayer(contentsOfURL: clickSoundfile)
        clickSound.prepareToPlay()
       // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if (userDefaults.objectForKey("fullversion") == nil) {
                userDefaults.setValue(false, forKey: "fullversion")
            }
            if (userDefaults.objectForKey("photos") == nil) {
                userDefaults.setValue(false, forKey: "photos")
            }
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
            if ((userDefaults.objectForKey("customimage")) == nil) {
                userDefaults.setValue(false, forKey: "customimage")
            }

      //  })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    @IBAction func buttonclick(sender: AnyObject) {
        clickSound.play()
    }
       
}


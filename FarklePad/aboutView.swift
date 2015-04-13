//
//  aboutView.swift
//  FarklePad
//
//  Created by Scott Johnson on 3/31/15.
//  Copyright (c) 2015 Out of Range Productions. All rights reserved.
//

import Foundation
import UIKit

class aboutView: UIViewController {
    @IBOutlet weak var verLabel: UILabel!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.clearColor()
        verLabel.text = "Version \(getVersion())"
    }
    func getVersion() -> String {
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "1.0"
    }

    @IBAction func tapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}
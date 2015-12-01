//
//  helpView.swift
//  FarklePad
//
//  Created by Scott Johnson on 3/30/15.
//  Copyright (c) 2015 Out of Range Productions. All rights reserved.
//

import Foundation
import UIKit
class helpView: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        var try6 = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("Text", ofType:"html")!)
        
        var request = NSURLRequest(URL: try6);
        webView.loadRequest(request)
        webView.layer.cornerRadius = 10
        webView.layer.borderWidth = 0.5
        webView.clipsToBounds = true
    }
    
    @IBAction func contactBtn(sender: AnyObject) {
        let email = "support@farklepad.com"
        let url = NSURL(string: "mailto:\(email)?subject=Help%20with%20FarklePad&")!
        UIApplication.sharedApplication().openURL(url)
    }
        func getVersion() -> String {
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "1.0"
    }
    
    
}
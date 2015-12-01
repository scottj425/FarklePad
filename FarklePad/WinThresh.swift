//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class WinThresh: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    var amounts = [String]()
    
    @IBOutlet var apicker: UIPickerView!
    @IBOutlet var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        var i:Int
        for i = 0; i < 101000; i += 1000 {
            amounts.append(String(i))
        }
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let thresh = userDefaults.objectForKey("winthreshold") as? String {
            
            apicker.selectRow(amounts.indexOf(thresh)!, inComponent: 0, animated: false)
            
        }

    }
    override func viewDidAppear(animated: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let fullVersion = userDefaults.valueForKey("fullversion") as! Bool
        if !fullVersion {
            self.dismissViewControllerAnimated(false, completion: nil)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return amounts.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return amounts[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(amounts[row], forKey: "winthreshold")
    }
    @IBAction func doneClick(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("diceColorChange", object: nil)
        self.dismissViewControllerAnimated(false, completion: nil)
    }

       
}


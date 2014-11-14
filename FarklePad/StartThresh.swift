//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class StartThresh: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    var amounts = [String]()
    
    @IBOutlet var apicker: UIPickerView!
    @IBOutlet var doneButton: NSObject!
    override func viewDidLoad() {
        super.viewDidLoad()
        var i:Int
        for i = 0; i < 5050; i += 50 {
            amounts.append(String(i))
        }
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let thresh = userDefaults.objectForKey("threshold") as? String {
            
            apicker.selectRow(find(amounts,thresh)!, inComponent: 0, animated: false)
            
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
        userDefaults.setValue(amounts[row], forKey: "threshold")
    }
    @IBAction func doneClick(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("diceColorChange", object: nil)
        self.dismissViewControllerAnimated(false, completion: nil)
    }

       
}


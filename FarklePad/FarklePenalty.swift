//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class FarklePenalty: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var fpicker: UIPickerView!
    var amounts = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        for var i = -2500; i < 0; i+=50 {
            amounts.append(String(i))
        }
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let farkle = userDefaults.objectForKey("farkle") as? String {
            
            fpicker.selectRow(amounts.indexOf(farkle)!, inComponent: 0, animated: false)
            
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
        print(amounts.count)
        return amounts.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return amounts[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(amounts[row], forKey: "farkle")
    }
    @IBAction func doneClick(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("diceColorChange", object: nil)
        self.dismissViewControllerAnimated(false, completion: nil)
    }

}


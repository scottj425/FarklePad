//
//
//  Created by Scott Johnson on 10/25/14.
//  Copyright (c) 2014 Scott Johnson. All rights reserved.
//

import UIKit

class DicePickerView: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var dpicker: UIPickerView!
    var colors = ["Blue","Orange","Purple","Tan","White"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let startColor = userDefaults.objectForKey("dicecolor") as? String {
            for var i = 0;i<colors.count;i++ {
                if (colors[i] == startColor) {
                    dpicker.selectRow(i, inComponent: 0, animated: false)
                }
            }
                
            
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
        return colors.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return colors[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(colors[row], forKey: "dicecolor")
    }
    @IBAction func doneclick(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("diceColorChange", object: nil)
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
}

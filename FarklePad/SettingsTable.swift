//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit

class SettingsTable: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

   var imagePicker = photoView()
    @IBOutlet var winLabel: UILabel!
    @IBOutlet var farkleLabel: UILabel!
    @IBOutlet var threshLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        colorLabel.text = (userDefaults.objectForKey("dicecolor") as String)
        threshLabel.text = (userDefaults.objectForKey("threshold") as String)
        winLabel.text = (userDefaults.objectForKey("winthreshold") as String)
        farkleLabel.text = (userDefaults.objectForKey("farkle") as String)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateColorLabel:", name: "diceColorChange", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateColorLabel(notification: NSNotification) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if ((userDefaults.objectForKey("dicecolor")) == nil) {
            userDefaults.setValue("Black", forKey: "dicecolor")
        }
        if ((userDefaults.objectForKey("threshold")) == nil) {
            userDefaults.setValue("500", forKey: "threshold")
        }
        if ((userDefaults.objectForKey("farkle")) == nil) {
            userDefaults.setValue("-500", forKey: "farkle")
        }
        colorLabel.text = (userDefaults.objectForKey("dicecolor") as String)
        threshLabel.text = (userDefaults.objectForKey("threshold") as String)
       farkleLabel.text = (userDefaults.objectForKey("farkle") as String)
        winLabel.text = (userDefaults.objectForKey("winthreshold") as String)

    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("index: \(indexPath)")
        let prefs = NSUserDefaults.standardUserDefaults()
        if indexPath == NSIndexPath(forItem: 0, inSection: 1) {
            
            let fullVersion = prefs.valueForKey("fullversion") as Bool
            if !fullVersion {
                let alert = UIAlertView(title: "", message: "Please purchase full version upgrade to use this feature.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                return
            }

        }
        if indexPath == NSIndexPath(forItem: 1, inSection: 1) {
            
            let fullVersion = prefs.valueForKey("fullversion") as Bool
            if !fullVersion {
                let alert = UIAlertView(title: "", message: "Please purchase full version upgrade to use this feature.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                return
            }
            
        }
        if indexPath == NSIndexPath(forItem: 2, inSection: 1) {
            
            let fullVersion = prefs.valueForKey("fullversion") as Bool
            if !fullVersion {
                let alert = UIAlertView(title: "", message: "Please purchase full version upgrade to use this feature.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                return
            }
            
        }
        if indexPath == NSIndexPath(forItem: 1, inSection: 0) {
            let photos = prefs.valueForKey("photos") as Bool
            if !photos {
                let alert = UIAlertView(title: "", message: "Please purchase photo background upgrade to use this feature.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                return
            }
            var cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            if (cell.accessoryType == UITableViewCellAccessoryType.Checkmark) {
             cell.accessoryType = UITableViewCellAccessoryType.None
            cell.selected=false
            prefs.setValue(false, forKey: "customimage")
                return
            }
            println("photo")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
                println("Button capture")
                
                
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        let prefs = NSUserDefaults.standardUserDefaults()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            var imageData = UIImagePNGRepresentation(image)
            
            prefs.setValue(imageData, forKey: "background")
            
            
        })
        prefs.setValue(true, forKey: "customimage")
        imagePicker.dismissViewControllerAnimated(false, completion: nil)
        var cell: UITableViewCell = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: 1, inSection: 0))!
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        self.tableView.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
            var custombg = userDefaults.objectForKey("customimage") as Bool
            if (custombg) {
                var cell: UITableViewCell = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: 1, inSection: 0))!
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                var cell: UITableViewCell = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: 1, inSection: 0))!
                cell.accessoryType = UITableViewCellAccessoryType.None
                
            }
    }
}


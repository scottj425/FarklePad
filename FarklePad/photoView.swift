//
//  photoView.swift
//  FarklePad
//
//  Created by Scott Johnson on 3/29/15.
//  Copyright (c) 2015 Out of Range Productions. All rights reserved.
//

import Foundation
import UIKit

class photoView: UIImagePickerController {
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
}
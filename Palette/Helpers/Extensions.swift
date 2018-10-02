//
//  Extensions.swift
//  Palette
//
//  Created by Saoirse on 9/30/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit
import Foundation

// MARK:- Extension UIColor
extension UIColor {
    /// Added a convenience initializer from Hex String. eg. "FFFF4E" (RGB no alpha).
    public convenience init(hexString: String) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1.0)
    }
}

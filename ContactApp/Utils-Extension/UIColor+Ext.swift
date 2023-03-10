//
//  UIColor+Ext.swift
//  ContactApp
//
//  Created by rishab-13586 on 12/12/22.
//

import Foundation
import UIKit

extension UIColor {
    public static func getUIColorFromHex(rgbValue:UInt32, alpha:Double=1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

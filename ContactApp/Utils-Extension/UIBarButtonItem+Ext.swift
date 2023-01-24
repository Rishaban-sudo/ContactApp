//
//  UIBarButtonItem+Ext.swift
//  ContactApp
//
//  Created by rishab-13586 on 04/01/23.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    public static func getDefaultButton() -> UIBarButtonItem {
        return UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

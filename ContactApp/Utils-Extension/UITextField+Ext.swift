//
//  UITextField+Ext.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import Foundation
import UIKit

extension UITextField {
    
    public static func getUITextFieldInstance(withBorderStyle: UITextField.BorderStyle) -> UITextField {
        let uiTextFieldInstance = UITextField()
        
        uiTextFieldInstance.translatesAutoresizingMaskIntoConstraints = false
        uiTextFieldInstance.borderStyle = withBorderStyle
        
        return uiTextFieldInstance
    }
    
}

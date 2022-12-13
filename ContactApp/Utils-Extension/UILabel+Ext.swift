//
//  UILabel+Ext.swift
//  ContactApp
//
//  Created by rishab-13586 on 12/12/22.
//

import Foundation
import UIKit

extension UILabel {
    public func setDefaultConfigurations(withFontSize size: CGFloat, adjustsFontSizeToFitWidth: Bool = false) {
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.font = self.font.withSize(size)
    }
}

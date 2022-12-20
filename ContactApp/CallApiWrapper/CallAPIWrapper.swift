//
//  CallAPIWrapper.swift
//  ContactApp
//
//  Created by rishab-13586 on 19/12/22.
//

import Foundation
import UIKit

class CallAPIWrapper {
    
    public static func makePhoneCall(contactNumber: String) {
        
        if let phoneCallURL = URL(string: "tel://\(contactNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
    }
    
}

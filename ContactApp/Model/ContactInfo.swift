//
//  ContactInfo.swift
//  ContactApp
//
//  Created by rishab-13586 on 08/12/22.
//

import Foundation
import UIKit

struct ContactInfo {
    var contactImage: UIImage!
    
    var contactName: String // of format first name_last name
    var contactNumber: String
    var email: String
    var dateOfBirth: String
    var notes: String
    
    public static func displayContactNameAsFullName(contactName: String) -> String {
        let fullNameArr = contactName.components(separatedBy: "_")
        return fullNameArr[0] + " " + fullNameArr[1]
    }
    
    public static func concatenateFirstNameAndLastNameToPersist(firstName: String, lastName: String) -> String {
        return firstName + "_" + lastName
    }
    
    public static func getFirstName(from contactName: String) -> String {
        return contactName.components(separatedBy: "_")[0]
    }
    
    public static func getLastName(from contactName: String) -> String {
        return contactName.components(separatedBy: "_")[1]
    }
    
}

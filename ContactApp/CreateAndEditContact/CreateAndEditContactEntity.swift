//
//  CreateAndEditContactEntity.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation

// MARK: This model is use to store or hold data for create/edit contact form
struct ContactDetail {
    var recordId: String
    var contactImage: UIImage?
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var dateOfBirth: String
    var notes: String
    
    init() {
        self.recordId     = ""
        self.contactImage = nil
        self.firstName    = ""
        self.lastName     = ""
        self.email        = ""
        self.phoneNumber  = ""
        self.dateOfBirth  = ""
        self.notes        = ""
    }
    
    init(contactImage: UIImage?) {
        self.init()
        self.contactImage = contactImage
        
    }
    
    init(contactInfo: ContactInfo) {
        let name = contactInfo.contactName
        self.recordId     = contactInfo.recordId
        self.contactImage = contactInfo.contactImage
        self.firstName    = ContactInfo.getFirstName(from: name)
        self.lastName     = ContactInfo.getLastName(from: name)
        self.email        = contactInfo.email
        self.phoneNumber  = contactInfo.contactNumber
        self.dateOfBirth  = contactInfo.dateOfBirth
        self.notes        = contactInfo.notes
    }
}

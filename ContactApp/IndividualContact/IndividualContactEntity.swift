//
//  IndividualContactEntity.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation

// MARK: Cell model for ImgContainerCell

struct ImgContainerModel {
    var contactImage: UIImage
    var contactName: String
    var contactNumber: String
}


// MARK: Cell model for ContactInfoContainerCell

struct ContactInfoContainerModel {
    var mobileNo: String
    var name: String
    var email: String
    var dateOfBirth: String
}

//
//  CreateAndEditContactEntity.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation

// MARK: This model is use to store or hold data for create/edit contact form
struct ContactDetail {
    var recordId: String!
    var contactImage: UIImage?
    var firstName: String!
    var lastName: String!
    var email: String!
    var phoneNumber: String!
    var dateOfBirth: String!
    var notes: String!
}

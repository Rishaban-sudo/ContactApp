//
//  ContactsDataSource.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import Foundation
import UIKit

struct ContactsDataSource {
    public static var datasource: [ContactInfo] = []
    
    public static func populateDummyData() {
        
        for i in 1...30 {
            datasource.append(ContactInfo(contactImage: Images.dummyContactImage,
                                               contactName: "Person \(i)_Z\(i)",
                                               contactNumber: "8870961690",
                                               email: "rishaban.ss@zohocorp.com",
                                               dateOfBirth: "2000/08/20",
                                               notes: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint jdbdhvwdhvbdk,.cd.dvfs avahc dolor do amet sint jdbdhvwdhvbdk,.cd.dvfs klwcjbdvsghcvjkfldkg fbd slosiougfcutgjklgfcdgxcfvjkl sdyvbksfjhgv ")
                                   )
        }
    }
    
    public static func getContactInfo(at index: Int) -> ContactInfo {
        return datasource[index]
    }
    
    public static func getTotalContacts() -> Int {
        return datasource.count
    }
    
    public static func addContactInfo(contact: ContactInfo) {
        datasource.append(contact)
    }
    
    
    
}

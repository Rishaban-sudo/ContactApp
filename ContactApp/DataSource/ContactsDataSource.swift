//
//  ContactsDataSource.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import Foundation
import UIKit
import ZCCoreFramework

protocol ContactsDataViewDelegate {
    func refreshTableView()
}


struct ContactsDataSource {
    public static var datasource: [ContactInfo] = []
    
    public static var contactsDataViewDelegate: ContactsDataViewDelegate?
    
    
    public static func fetchContactsFromZC(_ completionHandler: @escaping (Bool) -> Void) {
        let reportInfo = ReportInfo(openUrlInfo: nil,
                                    linkName: ContactAppConstants.AppComponents.AllContactInfos_LinkName,
                                    appDisplayname: nil,
                                    displayName: nil,
                                    notificationEnabled: false)
        
        let configuration = ListReportAPIConfiguration(fromIndex: 1, limit: 50, moreInfo: ReportAPIConfiguration.init())
        
        ZCAPIWrapper.fetchRecordsFromListReport(reportInfo: reportInfo, configuration: configuration) { (result) in
            switch result {
            case .success(let listReport):
                
                for record in listReport.records {
                    dump(record)
                    
                    var firstName = ""
                    var lastName = ""
                    var contactnumber = ""
                    var email = ""
                    var dateOfBirth = ""
                    var notes = ""
                    
                    do {
                        let contactImageRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.ContactImageField_LinkName).value
                        let firstNameRecordValue: RecordValue.Value = try record.recordValue(for: ContactAppConstants.ContactInfoForm.FirstNameField_LinkName).value
                        let lastNameRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.LastNameField_LinkName).value
                        let contactNumberRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.ContactNumberField_LinkName).value
                        let emailRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.EmailField_LinkName).value
                        let dateOfBirthRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.DateOfBirthField_LinkName).value
                        let notesRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.NotesField_LinkName).value
                        
                        if case let RecordValue.Value.file(fileValue) = contactImageRecordValue {
                            print(fileValue.valueUrl)
                            print(fileValue.fileName)
                            print(fileValue.fileType)
                        }
                        if case let RecordValue.Value.text(textValue) = firstNameRecordValue {
                            firstName = textValue.value
                        }
                        if case let RecordValue.Value.text(textValue) = lastNameRecordValue {
                            lastName = textValue.value
                        }
                        if case let RecordValue.Value.text(phoneNumber) = contactNumberRecordValue {
                            contactnumber = phoneNumber.value
                        }
                        if case let RecordValue.Value.text(textValue) = emailRecordValue {
                            email = textValue.value
                        }
                        if case let RecordValue.Value.text(textValue) = dateOfBirthRecordValue {
                            dateOfBirth = textValue.value
                        }
                        if case let RecordValue.Value.text(textValue) = notesRecordValue {
                            notes = textValue.value
                        }
                        
                        datasource.append(ContactInfo(recordId: record.recordID,
                                                      contactImage: Images.dummyContactImage, // as of now using default image
                                                      contactName: ContactInfo.concatenateFirstNameAndLastNameToPersist(firstName: firstName, lastName: lastName),
                                                      contactNumber: contactnumber,
                                                      email: email,
                                                      dateOfBirth: dateOfBirth,
                                                      notes: notes))
                        
                        
                    }
                    catch {
                        print("Unexpected error occurred while processing record value !!")
                        dump(error)
                    }
                }
                
                completionHandler(true)
                
            case .failure(let error):
                print("Some report error occurred !!")
                dump(error)
                completionHandler(false)
            }
        }
        
    }
    
    
//    public static func populateDummyData() {
//
//        for i in 1...30 {
//            datasource.append(ContactInfo(contactImage: Images.dummyContactImage,
//                                               contactName: "Person \(i)_Z\(i)",
//                                               contactNumber: "8870961690",
//                                               email: "rishaban.ss@zohocorp.com",
//                                               dateOfBirth: "2000/08/20",
//                                               notes: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint jdbdhvwdhvbdk,.cd.dvfs avahc dolor do amet sint jdbdhvwdhvbdk,.cd.dvfs klwcjbdvsghcvjkfldkg fbd slosiougfcutgjklgfcdgxcfvjkl sdyvbksfjhgv ")
//                                   )
//        }
//    }
    
    public static func getContactInfo(at index: Int) -> ContactInfo {
        return datasource[index]
    }
    
    public static func getTotalContacts() -> Int {
        return datasource.count
    }
    
    public static func addContactInfo(contact: ContactInfo) {
        var contact1 = contact
        ContactInfoFormHandler.submit(contactInfo: contact1) { (recordId) in
            contact1.setRecordId(recordId)
            datasource.append(contact1)
            self.contactsDataViewDelegate?.refreshTableView()
        }
    }
    
    public static func editContactInfo(at index: Int , contact: ContactInfo) {
        datasource[index].contactImage = contact.contactImage
        datasource[index].contactName = contact.contactName
        datasource[index].contactNumber = contact.contactNumber
        datasource[index].email = contact.email
        datasource[index].dateOfBirth = contact.dateOfBirth
        datasource[index].notes = contact.notes
        
        ContactInfoFormHandler.editContactinfo(contactInfo: contact)
    }
    
    public static func deleteContactInfo(at index: Int, recordId: String) {
        datasource.remove(at: index)
        ContactInfoFormHandler.deleteContactInfos(recordIds: [recordId])
    }
    
}

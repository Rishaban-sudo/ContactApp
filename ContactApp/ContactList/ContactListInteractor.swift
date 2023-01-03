//
//  ContactListInteractor.swift
//  ContactApp
//
//  Created by rishab-13586 on 28/12/22.
//

import Foundation
import ZCCoreFramework


class ContactListInteractor: PresenterToInteractorContactListProtocol {
    
    weak var presenter: InteractorToPresenterContactListProtocol?
    
    var contactsList: [ContactInfo] = []
    
    var contactImageRecordValDict: [Int : ZCCoreFramework.RecordValue] = [:]
    
    func fetchContactsFromZC() {
        let reportInfo = ReportInfo(openUrlInfo: nil,
                                    linkName: ContactAppConstants.AppComponents.AllContactInfos_LinkName,
                                    appDisplayname: nil,
                                    displayName: nil,
                                    notificationEnabled: false)
        
        var contactLastIndex = 0
        
        if let contactLastIndex1 = presenter?.getTotalNoOfcontacts() {
            contactLastIndex = contactLastIndex1
        }
        
        let configuration = ListReportAPIConfiguration(fromIndex: contactLastIndex + 1, limit: 50, moreInfo: ReportAPIConfiguration.init())
        
        ZCAPIWrapper.fetchRecordsFromListReport(reportInfo: reportInfo, configuration: configuration) { [self] (result) in
            switch result {
            case .success(let listReport):
                
                var currentContactIndex: Int = contactLastIndex  // should be index of last item index in tableview
                for record in listReport.records {
                    dump(record)
                    
                    var firstName = ""
                    var lastName = ""
                    var contactnumber = ""
                    var email = ""
                    var dateOfBirth = ""
                    var notes = ""
                    
                    do {
                        let contactImageRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.ContactImageField_LinkName)
                        let firstNameRecordValue: RecordValue.Value = try record.recordValue(for: ContactAppConstants.ContactInfoForm.FirstNameField_LinkName).value
                        let lastNameRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.LastNameField_LinkName).value
                        let contactNumberRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.ContactNumberField_LinkName).value
                        let emailRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.EmailField_LinkName).value
                        let dateOfBirthRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.DateOfBirthField_LinkName).value
                        let notesRecordValue = try record.recordValue(for: ContactAppConstants.ContactInfoForm.NotesField_LinkName).value
                    
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
                        
                        
                        let contactInfo = ContactInfo(recordId: record.recordID,
                                                      contactImage: Images.dummyContactImage, // as of now using default image
                                                      contactName: ContactInfo.concatenateFirstNameAndLastNameToPersist(firstName: firstName, lastName: lastName),
                                                      contactNumber: contactnumber,
                                                      email: email,
                                                      dateOfBirth: dateOfBirth,
                                                      notes: notes)
                        
                        
                        contactsList.append(contactInfo)
                        
                        
                        
                        contactImageRecordValDict[currentContactIndex] = contactImageRecordValue
                        
                        currentContactIndex = currentContactIndex + 1
                        
                    }
                    catch {
                        print("Unexpected error occurred while processing record value !!")
                        dump(error)
                    }
                }
                
                presenter?.contactListFetchSuccess(contacts: contactsList)
                
            case .failure(let error):
                print("Some report error occurred !!")
                dump(error)
                presenter?.contactListFetchFailure(error: error.localizedDescription)
            }
            
        }
    }
    
    func fetchContactImages() {
        for (contactIndex, contactImageRecordValue) in contactImageRecordValDict {
            
            ZCAPIWrapper.downloadMedia(from: contactImageRecordValue) { [weak self] (result) in
                switch result {
                case .success(let data):

                    let contactImage = UIImage(data: data)
                    self?.contactsList[contactIndex].contactImage = contactImage
                    self?.presenter?.imageFetchSuccess(contactImage: contactImage!, at: contactIndex)

                case .failure(let error):
                    print("Failed to download contact image from server !!")
                    dump(error)
                }
            }
            
        }
        
        contactImageRecordValDict.removeAll()
    }
    
    func clearCache() {
        self.contactsList.removeAll()
    }
    
}

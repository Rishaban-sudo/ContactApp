//
//  ContactInfoFormHandler.swift
//  ContactApp
//
//  Created by rishab-13586 on 22/12/22.
//

import Foundation
import ZCCoreFramework

class ContactInfoFormHandler {
    private static var contactInfoForm: Form?
    private static var formFieldsFieldAccessPaths: [String : FieldAccessPath] = [:] // [field_linkname : FieldAccessPath]
    
    
    private static func fetchContactInfoForm(completionHandler: @escaping (Bool) -> Void) {
        
        if contactInfoForm == nil {
            let formInfo = FormInfo(linkName: ContactAppConstants.AppComponents.ContactInfoForm_LinkName,
                                    displayName: ContactAppConstants.AppComponents.ContactInfoForm_DisplayName)
            
            ZCAPIWrapper.fetchForm(for: formInfo) { (result) in
                switch result {
                case .success(let workFlowChangeSet):
                    contactInfoForm = workFlowChangeSet.alteredForm
                    setFieldAcccessPathForAllFields()
                    completionHandler(true)
                case .failure(let error):
                    print("Error occurred while fetching Form !!")
                    dump(error)
                    completionHandler(false)
                }
            }
        }
        else {
            completionHandler(true)
        }
        
    }
    
    private static func setFieldAcccessPathForAllFields() {
        let fields: [FieldProtocol] = contactInfoForm!.fields
        
        for field in fields {
            formFieldsFieldAccessPaths[field.linkName] = FieldAccessPath.field(linkName: field.linkName)
        }
        dump(formFieldsFieldAccessPaths)
    }
    
    private static func setValueForField(with fieldAccessPath: FieldAccessPath, value: InputValues) {
        let field = contactInfoForm?.getField(using: fieldAccessPath)
        
        if let modifiedField = field?.setValueFor(value: value) {
            contactInfoForm?.setField(modifiedField)
        }
    }
    
    private static func setValuesForContactInfoForm(contactInfo: ContactInfo, imageFilename: String) {
        guard let fields = contactInfoForm?.fields else { return }
        
        for field in fields {
            
            switch field.linkName {
            case ContactAppConstants.ContactInfoForm.ContactImageField_LinkName:

                let contactImageFieldAccessPath = formFieldsFieldAccessPaths[field.linkName]!
               
                if let contactImageField = contactInfoForm?.getField(using: contactImageFieldAccessPath),
                   case var InputValues.imageFieldValue(contactImageFieldvalue) = contactImageField.getValue() {
                    
                    
                    contactImageFieldvalue.sourcePath = "/sharedBy/appLinkName/viewLinkName/fieldName/image/" + imageFilename
                    setValueForField(with: formFieldsFieldAccessPaths[field.linkName]!, value: .imageFieldValue(fieldValue: contactImageFieldvalue))
                    
                }

            case ContactAppConstants.ContactInfoForm.FirstNameField_LinkName:
                
                setValueForField(with: formFieldsFieldAccessPaths[field.linkName]!, value: .textFieldValue(fieldValue: ContactInfo.getFirstName(from: contactInfo.contactName)))
                
            case ContactAppConstants.ContactInfoForm.LastNameField_LinkName:
                
                setValueForField(with: formFieldsFieldAccessPaths[field.linkName]!, value: .textFieldValue(fieldValue: ContactInfo.getLastName(from: contactInfo.contactName)))
                
            case ContactAppConstants.ContactInfoForm.ContactNumberField_LinkName:
                
                setValueForField(with: formFieldsFieldAccessPaths[field.linkName]!, value: .textFieldValue(fieldValue: contactInfo.contactNumber))
                
            case ContactAppConstants.ContactInfoForm.EmailField_LinkName:
                
                setValueForField(with: formFieldsFieldAccessPaths[field.linkName]!, value: .textFieldValue(fieldValue: contactInfo.email))
                
            case ContactAppConstants.ContactInfoForm.DateOfBirthField_LinkName:
                
                setValueForField(with: formFieldsFieldAccessPaths[field.linkName]!, value: .textFieldValue(fieldValue: contactInfo.dateOfBirth))
                
            case ContactAppConstants.ContactInfoForm.NotesField_LinkName:
                
                setValueForField(with: formFieldsFieldAccessPaths[field.linkName]!, value: .textFieldValue(fieldValue: contactInfo.notes))
                
            default:
                print("Some other field !!")
            }
        }
        
    }
    
    public static func submit(contactInfo: ContactInfo, completion: @escaping (String) -> Void) {  // to get recordId when submitting the form
        
        fetchContactInfoForm() { (status) in
            
            if status {
                
                submitImageField(contactInfo: contactInfo) { (result) in
                    switch result {
                    case .success(let fileUploadResponse):
                        print("Image uploaded successfully !")
                        dump(fileUploadResponse)
                        
                        setValuesForContactInfoForm(contactInfo: contactInfo, imageFilename: fileUploadResponse.fileName)
                        
                        guard let form = contactInfoForm else { return }
                        
                        dump(form)
                        ZCAPIWrapper.submitForm(form: form) { (result) in
                            switch result {
                            case .success(let submitResponse):
                                print("Form data sent sucessfully !!")
                                
                                switch submitResponse {
                                case .success(let successResponse):
                                    print("Form Submitted successfully !!")
                                    dump(successResponse)
                                    completion(successResponse.recordId!)
                                case .failure(let failureResponse):
                                    print("Some error ocurred while putting data !!")
                                    dump(failureResponse)
                                }
                                
                            case .failure(let error):
                                print("Error occurred while submitting form !!")
                                dump(error)
                            }
                        }
                        
                        
                    case .failure(let error):
                        print("Error occurred while uploading image !")
                        dump(error)
                    }
                }
                
                
                
            }
            
            
        }
        
    }
    
    public static func editContactinfo(contactInfo: ContactInfo) {
        fetchContactInfoForm() { (status) in
            
            if status {
                
                
                submitImageField(contactInfo: contactInfo) { (result) in
                    switch result {
                    case .success(let fileUploadResponse):
                        print("Image uploaded successfully !")
                        dump(fileUploadResponse)
                        
                        setValuesForContactInfoForm(contactInfo: contactInfo, imageFilename: fileUploadResponse.fileName)
                        
                        guard let form = contactInfoForm else { return }
                        
                        dump(form)
                        ZCAPIWrapper.updateRecord(withRecordId: contactInfo.recordId,
                                                  inReportLinkName: ContactAppConstants.AppComponents.AllContactInfos_LinkName, form: form) { (result) in
                            switch result {
                            case .success(let submitResponse):
                                
                                print("Record Data sent successfully !")
                                
                                switch submitResponse {
                                case .success(let successResponse):
                                    print("Record updated successfully !!")
                                    dump(successResponse)
                                case .failure(let failureResponse):
                                    print("Error occurred while updating record !!")
                                    dump(failureResponse)
                                }
                            case .failure(let error):
                                print("Error occurred while updating record !!")
                                dump(error)
                            }
                        }
                        
                    case .failure(let error):
                        print("Error occurred while uploading image !")
                        dump(error)
                    }
                }
                

            }
            
        }
    }
    
    public static func deleteContactInfos(recordIds: [String]) {
        fetchContactInfoForm { (status) in
            
            if status {
                
                let reportInfo = ReportInfo(openUrlInfo: nil,
                                            linkName: ContactAppConstants.AppComponents.AllContactInfos_LinkName,
                                            appDisplayname: nil,
                                            displayName: nil,
                                            notificationEnabled: false)
                
                ZCAPIWrapper.deleteRecords(withRecordIds: recordIds, in: reportInfo) { (result) in
                    switch result {
                    case .success(let deleteResponse):
                        print("Successfully deleted records !!")
                        dump(deleteResponse)
                    case .failure(let error):
                        print("Error occurred !!")
                        dump(error)
                    }
                }
            }
            
        }
    }
    
    private static func submitImageField(contactInfo: ContactInfo, completionhandler: @escaping (Result<FileUploadResponse>) -> Void) {
        
        guard let imageData = contactInfo.contactImage.jpegData(compressionQuality: 1) else { return }
        
        let contactImageFieldAccessPath = formFieldsFieldAccessPaths[ContactAppConstants.ContactInfoForm.ContactImageField_LinkName]!
        
        ZCAPIWrapper.uploadMedia(media: imageData, withFileName: contactInfo.contactName + ".jpeg", for: contactImageFieldAccessPath, form: contactInfoForm!, completionhandler: completionhandler)
        
    }
    
}

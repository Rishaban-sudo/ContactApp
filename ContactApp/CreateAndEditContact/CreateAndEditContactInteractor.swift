//
//  CreateAndEditContactInteractor.swift
//  ContactApp
//
//  Created by rishab-13586 on 03/01/23.
//

import Foundation
import UIKit

class CreateAndEditContactInteractor: PresenterToInteractorCreateAndEditContactProtocol {
    
    var presenter: InteractorToPresenterCreateAndEditContactProtocol?
    
    var contactInfo: ContactInfo!
    
    
    func getIndividualContactInfo() -> ContactInfo {
        return contactInfo
    }
    
    func addContact(contact: ContactInfo) {
        ContactInfoFormHandler.submit(contactInfo: contact) { (isSuccess, message) in
            if isSuccess {
                self.presenter?.onAddContactSuccess(message: message)
            }
            else {
                self.presenter?.onAddConatctFailure(message: message)
            }
        }
    }
    
}

//
//  IndividualContactInteractor.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation
import UIKit

class IndividualContactInteractor: PresenterToInteractorIndividualContactProtocol {
    var presenter: InteractorToPresenterIndividualContactProtocol?
    
    var contactInfo: ContactInfo!
    
    func getIndividualContactInfo() -> ContactInfo {
        return contactInfo
    }
    
    func deleteContact(recordIds: [String]) {
        ContactInfoFormHandler.deleteContactInfos(recordIds: recordIds) { (isSucess, message) in
            if isSucess {
                self.presenter?.onDeleteContactSuccess(message: message)
            }
            else {
                self.presenter?.onDeleteContactFailure(message: message)
            }
        }
    }
    
    
}

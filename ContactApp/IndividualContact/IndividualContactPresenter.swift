//
//  IndividualContactPresenter.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation
import UIKit

class IndividualContactPresenter: ViewToPresenterIndividualContactProtocol {
    
    weak var view: PresenterToViewIndividualContactProtocol?
    var interactor: PresenterToInteractorIndividualContactProtocol?
    var router: PresenterToRouterIndividualContactProtocol?
    
    private let _noOfCells: Int = 3
    
    
    //    private var recordId: String!
    //    private var contactImage: UIImage!
    //    private var contactName: String!
    //    private var contactNumber: String!
    //    private var email: String!
    //    private var dateOfBirth: String!
    //    private var notes: String!
    //
    //    private var index: Int!
    
    
    
    var contactInfo: ContactInfo!
    
    func viewDidLoad() {
        // Get the contact info from interactor
        contactInfo = interactor?.getIndividualContactInfo()
    }
    
    func viewWillAppear() {
        
    }
    
    func numberOfRowsInSection() -> Int {
        return _noOfCells
    }
    
    func setCellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImgContainerCell.cellIdentifier, for: indexPath) as! ImgContainerCell
            
            
            let imgContainerModel = ImgContainerModel(contactImage: contactInfo.contactImage,
                                                      contactName: ContactInfo.displayContactNameAsFullName(contactName: contactInfo.contactName),
                                                      contactNumber: contactInfo.contactNumber)
            
            cell.setCellContext(with: imgContainerModel)
            
            cell.getContactImageView().addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
            cell.getCallButton().addTarget(self, action: #selector(callNumber), for: .touchUpInside)
            
            cell.isUserInteractionEnabled = true
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactInfoContainerCell.cellIdentifier, for: indexPath) as! ContactInfoContainerCell
            
            
            let contactInfoContainerModel = ContactInfoContainerModel(mobileNo: contactInfo.contactNumber,
                                                                      name: ContactInfo.displayContactNameAsFullName(contactName: contactInfo.contactName),
                                                                      email: contactInfo.email,
                                                                      dateOfBirth: contactInfo.dateOfBirth)
            
            cell.setCellContext(with: contactInfoContainerModel)
            
            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotesContainerCell.cellIdentifier, for: indexPath) as! NotesContainerCell
            
            cell.setCellContext(notes: contactInfo.notes)
            
            cell.isUserInteractionEnabled = false
            return cell
        default:
            fatalError("unbounded index !!")
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath, tableView: UITableView) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
}

extension IndividualContactPresenter {
    
    @objc private func imageTapped() {
        let imagePreviewPopVC = ImagePreviewPopVC()
        imagePreviewPopVC.setImagePreview(with: self.contactInfo.contactImage)
        
        imagePreviewPopVC.modalPresentationStyle = .overCurrentContext
        imagePreviewPopVC.modalTransitionStyle   = .crossDissolve
        
        view?.presentPopUpView(view: imagePreviewPopVC, animated: true)
    }
    
}

extension IndividualContactPresenter {
    
    @objc private func callNumber() {
        CallAPIWrapper.makePhoneCall(contactNumber: self.contactInfo.contactNumber)
    }
    
}


extension IndividualContactPresenter: InteractorToPresenterIndividualContactProtocol {
    
}

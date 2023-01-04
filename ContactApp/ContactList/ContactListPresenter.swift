//
//  ContactListPresenter.swift
//  ContactApp
//
//  Created by rishab-13586 on 27/12/22.
//

import Foundation
import UIKit

class ContactListPresenter: ViewToPresenterContactListProtocol {

    var contactList = [ContactInfo]()
    private let queue = DispatchQueue.global(qos: .default)
    
    private var flag = true
    private var switchFlag = false
    
    weak var view: PresenterToViewContactListProtocol?
    var interactor: PresenterToInteractorContactListProtocol?
    var router: PresenterToRouterContactListProtocol?
    
    func viewDidLoad() {
        
        // show loading activity while fetching data from server
        view?.showActivityIndicator()
        
        // fetch data from interactor
        interactor?.fetchContactsFromZC()
    }
    
    func viewWillAppear() {
        if !flag {
            setFlagState(to: true)
            view?.makeAddButtonAppear()
        }
    }
    
    
    func numberOfRowsInSection() -> Int {
        return contactList.count
    }
    
    func setCellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if switchFlag == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactInfoCell.cellIdentifier, for: indexPath) as! ContactInfoCell
            let contactInfo = contactList[indexPath.row]


            let contactInfoCellModel = ContactInfoCellModel(contactImage: contactInfo.contactImage,
                                                            contactNameLabel: ContactInfo.displayContactNameAsFullName(contactName: contactInfo.contactName),
                                                            contactNumberlabel: contactInfo.contactNumber)
            
            cell.setCellModel(contactInfoCellModel: contactInfoCellModel)

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LargeTileContactinfoCell.cellIdentifier, for: indexPath) as! LargeTileContactinfoCell
            let contactInfo = contactList[indexPath.row]

            let contactInfoCellModel = ContactInfoCellModel(contactImage: contactInfo.contactImage,
                                                            contactNameLabel: ContactInfo.displayContactNameAsFullName(contactName: contactInfo.contactName),
                                                            contactNumberlabel: contactInfo.contactNumber)
            
            cell.setCellModel(contactInfoCellModel: contactInfoCellModel)
            

            return cell
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath, tableView: UITableView) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        setFlagState(to: false)
        view?.makeAddButtonDisAppear()
        
        // From this presenter we will call the router to navigate to IndividualContact Screen
        // Also we will pass the contact info to the router
        let contactInfo = contactList[indexPath.row]
        router?.pushIndividualContactDetail(on: view, with: contactInfo)
    }
    
    func canEditRowAt(indexPath: IndexPath, tableView: UITableView) -> Bool {
        return true
    }
    
    func editActionsForRowAt(indexPath: IndexPath, tableView: UITableView) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive,
                                                title: "Delete",
                                                handler: { (action, indexpath) in
            let contactInfo = self.contactList[indexPath.row]
            ContactInfoFormHandler.deleteContactInfos(recordIds: [contactInfo.recordId]) { (isSucess, message) in
                if isSucess {
                    self.contactList.remove(at: indexpath.row)
                    self.interactor?.deleteContact(at: indexpath.row)
                    
                    tableView.deleteRows(at: [indexpath], with: .automatic)
                }
                else {
                    self.view?.showAlert(title: "Contact Deletion Failed", message: message)
                }
            }
        })
        
        return [deleteAction]
        
    }
    

    func setSwitchState(to state: Bool) {
        switchFlag = state
    }
    
    func setFlagState(to state: Bool) {
        flag = state
    }
    
    func reloadTableView() {
        view?.reloadTableView()
    }
    
    func pushCreateAndEditContactVC() {
        // router -> create and edit VC router
        router?.pushCreateContactView(on: view)
    }
    
    func refetchData() {
        view?.showActivityIndicator()
        
        self.contactList.removeAll()
        reloadTableView()
        
        // clear the previous data and fetch new data from interactor
        interactor?.clearCache()
        interactor?.fetchContactsFromZC()
    }
    
}



extension ContactListPresenter: InteractorToPresenterContactListProtocol {
    
    func getTotalNoOfcontacts() -> Int {
        return contactList.count
    }
    
    func onSingleContactFetchSuccess(contact: ContactInfo) {
        contactList.append(contact)
    }
    
    func contactListFetchSuccess(contacts: [ContactInfo]) {
        self.contactList.append(contentsOf: contacts)
        
        view?.hideActivityIndicator()
        
        DispatchQueue.main.async {
            self.view?.onContactListFetchSuccess()
        }
        
        queue.async {
            self.interactor?.fetchContactImages()
        }
        
    }
    
    func contactListFetchFailure(error: String) {
        print(error)
        view?.onContactListFetchFailure(error: error)
    }
    
    func imageFetchSuccess(contactImage: UIImage, at index: Int) {
        contactList[index].contactImage = contactImage
        let indexPath = IndexPath(row: index, section: 0)
        view?.reloadTableViewRows(at: [indexPath], with: .automatic)
    }
    
}

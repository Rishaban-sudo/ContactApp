//
//  ContactListRouter.swift
//  ContactApp
//
//  Created by rishab-13586 on 28/12/22.
//

import Foundation
import UIKit

class ContactListRouter: PresenterToRouterContactListProtocol {
    
    deinit {
        print("Deinit ContactListInteractor")
    }
    
    static func createModule() -> UINavigationController {
        let contactListviewController = ContactListViewController()
        
        
        let presenter: (ViewToPresenterContactListProtocol & InteractorToPresenterContactListProtocol) = ContactListPresenter()
        
        contactListviewController.presenter = presenter
        
        contactListviewController.presenter?.router = ContactListRouter()
        contactListviewController.presenter?.view = contactListviewController
        contactListviewController.presenter?.interactor = ContactListInteractor()
        
        
        contactListviewController.presenter?.interactor?.presenter = presenter
        
        let navController = UINavigationController(rootViewController: contactListviewController)
        
        navController.view.addSubview(contactListviewController.getAddButton())
        
        return navController
    }
    
    func pushIndividualContactDetail(on view: PresenterToViewContactListProtocol?, with contactInfo: ContactInfo) {
        // push the individual contact view controller upon this view navigation controller
        // which get returned from individual contact module router
        // along with that pass the contact info model to the viewcontroller
        
        let individualContactViewController = IndividualContactRouter.createModule(with: contactInfo)
        
        if let contactListViewController = view as? ContactListViewController {
            contactListViewController.navigationController?.pushViewController(individualContactViewController, animated: true)
        }
        
    }
    
    
    func pushCreateContactView(on view: PresenterToViewContactListProtocol?) {
        let vc = CreateAndEditContactRouter.createModule()
        
        guard let createAndEditViewController = vc as? CreateAndEditViewController else { return }
        
        createAndEditViewController.configureAsCreateContactView()
        
        if let contactListViewController = view as? ContactListViewController {
            contactListViewController.navigationController?.pushViewController(createAndEditViewController, animated: true)
        }
        
    }
    
}

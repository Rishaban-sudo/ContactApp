//
//  CreateAndEditContactRouter.swift
//  ContactApp
//
//  Created by rishab-13586 on 03/01/23.
//

import Foundation
import UIKit

class CreateAndEditContactRouter: PresenterToRouterCreateAndEditContactProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(with contact: ContactInfo? = nil) -> UIViewController {
        let createAndEditContactViewcontroller = CreateAndEditViewController()
        
        
        let presenter: (ViewToPresenterCreateAndEditContactProtocol & InteractorToPresenterCreateAndEditContactProtocol) = CreateAndEditContactPresenter()
        
        createAndEditContactViewcontroller.presenter = presenter
        
        let router = CreateAndEditContactRouter()
        
        createAndEditContactViewcontroller.presenter?.router = router
        createAndEditContactViewcontroller.presenter?.view = createAndEditContactViewcontroller
        createAndEditContactViewcontroller.presenter?.interactor = CreateAndEditContactInteractor()
        
        createAndEditContactViewcontroller.presenter?.interactor?.contactInfo = contact
        
        createAndEditContactViewcontroller.presenter?.interactor?.presenter = presenter
        
        router.viewController = createAndEditContactViewcontroller
        
        return createAndEditContactViewcontroller
    }
    
    func popToHomeScreen() {
        if let contactListViewController = viewController?.navigationController?.viewControllers[0] as? ContactListViewController {
            contactListViewController.refreshScreen()
        }
        
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
}

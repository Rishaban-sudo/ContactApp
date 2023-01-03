//
//  CreateAndEditContactRouter.swift
//  ContactApp
//
//  Created by rishab-13586 on 03/01/23.
//

import Foundation
import UIKit

class CreateAndEditContactRouter: PresenterToRouterCreateAndEditContactProtocol {
    
    static func createModule(with contact: ContactInfo? = nil) -> UIViewController {
        let createAndEditContactViewcontroller = CreateAndEditViewController()
        
        
        let presenter: (ViewToPresenterCreateAndEditContactProtocol & InteractorToPresenterCreateAndEditContactProtocol) = CreateAndEditContactPresenter()
        
        createAndEditContactViewcontroller.presenter = presenter
        
        createAndEditContactViewcontroller.presenter?.router = CreateAndEditContactRouter()
        createAndEditContactViewcontroller.presenter?.view = createAndEditContactViewcontroller
        createAndEditContactViewcontroller.presenter?.interactor = CreateAndEditContactInteractor()
        
        createAndEditContactViewcontroller.presenter?.interactor?.contactInfo = contact
        
        createAndEditContactViewcontroller.presenter?.interactor?.presenter = presenter
        
        return createAndEditContactViewcontroller
    }
    
    func popToHomeScreen(navController: UINavigationController) {
        
        if let contactListViewController = navController.viewControllers[0] as? ContactListViewController {
            contactListViewController.refreshScreen()
        }
        
        navController.popToRootViewController(animated: true)
    }
    
}

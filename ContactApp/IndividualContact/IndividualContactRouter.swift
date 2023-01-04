//
//  IndividualContactRouter.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation
import UIKit

class IndividualContactRouter: PresenterToRouterIndividualContactProtocol {
    
    static func createModule(with contact: ContactInfo) -> UIViewController {
        let individualContactViewController = IndividualContactViewController()
        
        
        let presenter: (ViewToPresenterIndividualContactProtocol & InteractorToPresenterIndividualContactProtocol) = IndividualContactPresenter()
        
        individualContactViewController.presenter = presenter
        
        individualContactViewController.presenter?.router = IndividualContactRouter()
        individualContactViewController.presenter?.view = individualContactViewController
        individualContactViewController.presenter?.interactor = IndividualContactInteractor()
        
        individualContactViewController.presenter?.interactor?.contactInfo = contact
        
        individualContactViewController.presenter?.interactor?.presenter = presenter
        
        return individualContactViewController
    }
    
    func pushEditContactView(on view: PresenterToViewIndividualContactProtocol?, with contactInfo: ContactInfo) {
        let vc = CreateAndEditContactRouter.createModule(with: contactInfo)
        
        guard let createAndEditViewController = vc as? CreateAndEditViewController else { return }
        
        createAndEditViewController.configureAsEditContactView()
        
        if let individualContactViewController = view as? IndividualContactViewController {
            individualContactViewController.navigationController?.pushViewController(createAndEditViewController, animated: true)
        }
    }
    
    func popToHomeScreen(navController: UINavigationController) {
        
        if let contactListViewController = navController.viewControllers[0] as? ContactListViewController {
            contactListViewController.refreshScreen()
        }
        
        navController.popToRootViewController(animated: true)
    }
    
}

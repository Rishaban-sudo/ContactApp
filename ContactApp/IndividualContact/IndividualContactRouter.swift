//
//  IndividualContactRouter.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation
import UIKit

class IndividualContactRouter: PresenterToRouterIndividualContactProtocol {
    
    weak var viewController: UIViewController?
    
    
    deinit {
        print("Deinit IndividualContactRouter")
    }
    
    
    private lazy var deleteContactPopVC = {
        let deleteContactPopVC = DeleteContactPopVC()
        
        deleteContactPopVC.modalPresentationStyle = .overCurrentContext
        deleteContactPopVC.modalTransitionStyle   = .crossDissolve
        
        deleteContactPopVC.getDeleteButton().addTarget(self, action: #selector(deleteContact), for: .touchUpInside)
        
        return deleteContactPopVC
    } ()
    
    
    @objc private func deleteContact() {
        if let individualContactViewController = viewController as? IndividualContactViewController {
            deleteContactPopVC.dismiss(animated: true)
            individualContactViewController.presenter?.deleteContact()
        }
    }
    
    
    
    static func createModule(with contact: ContactInfo) -> UIViewController {
        let individualContactViewController = IndividualContactViewController()
        
        
        let presenter: (ViewToPresenterIndividualContactProtocol & InteractorToPresenterIndividualContactProtocol) = IndividualContactPresenter()
        
        individualContactViewController.presenter = presenter
        
        let router = IndividualContactRouter()
        
        individualContactViewController.presenter?.router = router
        individualContactViewController.presenter?.view = individualContactViewController
        individualContactViewController.presenter?.interactor = IndividualContactInteractor()
        
        individualContactViewController.presenter?.interactor?.contactInfo = contact
        
        individualContactViewController.presenter?.interactor?.presenter = presenter
        
        router.viewController = individualContactViewController
        
        return individualContactViewController
    }
    
    func popUpImageView(contactImage: UIImage) {
        let imagePreviewPopVC = ImagePreviewPopVC()
        imagePreviewPopVC.setImagePreview(with: contactImage)
        
        imagePreviewPopVC.modalPresentationStyle = .overCurrentContext
        imagePreviewPopVC.modalTransitionStyle   = .crossDissolve
        
        viewController?.present(imagePreviewPopVC, animated: true)
    }
    
    func popUpDeleteContactView() {
        viewController?.present(deleteContactPopVC, animated: true)
    }
    
    func pushEditContactView(on view: PresenterToViewIndividualContactProtocol?, with contactInfo: ContactInfo) {
        let vc = CreateAndEditContactRouter.createModule(with: contactInfo)
        
        guard let createAndEditViewController = vc as? CreateAndEditViewController else { return }
        
        createAndEditViewController.configureAsEditContactView()
        
        if let individualContactViewController = view as? IndividualContactViewController {
            individualContactViewController.navigationController?.pushViewController(createAndEditViewController, animated: true)
        }
    }
    
    func popToHomeScreen() {
        if let contactListViewController = viewController?.navigationController?.viewControllers[0] as? ContactListViewController {
            contactListViewController.refreshScreen()
        }
        
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
}

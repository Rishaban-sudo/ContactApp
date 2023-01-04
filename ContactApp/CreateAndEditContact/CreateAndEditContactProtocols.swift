//
//  CreateAndEditContactProtocols.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation
import UIKit


// MARK: - (View -> Presenter) view will delegate view logic to the presenter
protocol ViewToPresenterCreateAndEditContactProtocol: AnyObject {
    var view: PresenterToViewCreateAndEditContactProtocol? { get set }
    var router: PresenterToRouterCreateAndEditContactProtocol? { get set }
    
    
    
    func viewDidLoad()
    func viewWillAppear()
    
    // tableview delegate methods
    func numberOfRowsInSection() -> Int
    func setCellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func didSelectRowAt(indexPath: IndexPath, tableView: UITableView)
    
    //isEditView flag method
    func setIsEditView(to state: Bool)
    
    func saveButtonTapped()
    
    func returnToContactListScreen(navController: UINavigationController)
}

// MARK: - (Presenter -> View) presenter will update the view
protocol PresenterToViewCreateAndEditContactProtocol: AnyObject {
//    var presenter: ViewToPresenterContactListProtocol? { get set }
    
    func setViewTitle(title: String)
    
    func present(viewControllerToPresent: UIViewController, animated flag: Bool)
    func showLoadingScreen()
    func dismissLoadingScreen()
    
    func endEditing(_ force: Bool)
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell?
    
    func showAlert(title: String, message: String)
    func showAlertWith(title: String, message: String)
}





// MARK: - (Presenter -> Interactor) presenter will ask for data to interactor
protocol PresenterToInteractorCreateAndEditContactProtocol: AnyObject {
    var presenter: InteractorToPresenterCreateAndEditContactProtocol? { get set }
    var contactInfo: ContactInfo! { get set }
    
    func getIndividualContactInfo() -> ContactInfo
    func addContact(contact: ContactInfo)
    func editContact(contact: ContactInfo)
}

// MARK: - (Interactor -> Presenter) interactor will give data to the presenter
protocol InteractorToPresenterCreateAndEditContactProtocol: AnyObject {
    var interactor: PresenterToInteractorCreateAndEditContactProtocol? { get set }
    
    func onAddContactSuccess(message: String)
    func onAddConatctFailure(message: String)
    
    func onEditContactSuccess(message: String)
    func onEditContactFailure(message: String)
}


// MARK: - (Presenter -> Router)
protocol PresenterToRouterCreateAndEditContactProtocol: AnyObject {
    static func createModule(with contact: ContactInfo?) -> UIViewController
    
    func popToHomeScreen(navController: UINavigationController)
}

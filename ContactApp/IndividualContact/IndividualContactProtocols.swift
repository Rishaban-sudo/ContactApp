//
//  IndividulaContactProtocols.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation



// MARK: - (View -> Presenter) view will delegate view logic to the presenter
protocol ViewToPresenterIndividualContactProtocol: AnyObject {
    var view: PresenterToViewIndividualContactProtocol? { get set }
    var router: PresenterToRouterIndividualContactProtocol? { get set }
    
    
    
    func viewDidLoad()
    func viewWillAppear()
    
    // tableview delegate methods
    func numberOfRowsInSection() -> Int
    func setCellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func didSelectRowAt(indexPath: IndexPath, tableView: UITableView)
    
    func editButtonTapped()
    func deleteButtonTapped()
    
    func returnToContactListScreen(navController: UINavigationController)
}

// MARK: - (Presenter -> View) presenter will update the view
protocol PresenterToViewIndividualContactProtocol: AnyObject {
//    var presenter: ViewToPresenterContactListProtocol? { get set }
    func presentPopUpView(view: UIViewController, animated: Bool)
    
    func showLoadingScreen()
    func dismissLoadingScreen()
    
    func showAlert(title: String, message: String)
    func showAlertWith(title: String, message: String)
}





// MARK: - (Presenter -> Interactor) presenter will ask for data to interactor
protocol PresenterToInteractorIndividualContactProtocol: AnyObject {
    var presenter: InteractorToPresenterIndividualContactProtocol? { get set }
    var contactInfo: ContactInfo! { get set }
    
    func getIndividualContactInfo() -> ContactInfo
    func deleteContact(recordIds: [String])
}

// MARK: - (Interactor -> Presenter) interactor will give data to the presenter
protocol InteractorToPresenterIndividualContactProtocol: AnyObject {
    var interactor: PresenterToInteractorIndividualContactProtocol? { get set }
    
    func onDeleteContactSuccess(message: String)
    func onDeleteContactFailure(message: String)
}









// MARK: - (Presenter -> Router)
protocol PresenterToRouterIndividualContactProtocol: AnyObject {
    static func createModule(with contact: ContactInfo) -> UIViewController
    
    func pushEditContactView(on view: PresenterToViewIndividualContactProtocol?, with contactInfo: ContactInfo)
    func popToHomeScreen(navController: UINavigationController)
}

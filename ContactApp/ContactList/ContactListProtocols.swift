//
//  ContactListProtocols.swift
//  ContactApp
//
//  Created by rishab-13586 on 27/12/22.
//

import Foundation
import UIKit

// MARK: - (View -> Presenter) view will delegate view logic to the presenter
protocol ViewToPresenterContactListProtocol: AnyObject {
    var view: PresenterToViewContactListProtocol? { get set }
    var router: PresenterToRouterContactListProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    // tableview delegate methods
    func numberOfRowsInSection() -> Int
    func setCellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func didSelectRowAt(indexPath: IndexPath, tableView: UITableView)
    func canEditRowAt(indexPath: IndexPath, tableView: UITableView) -> Bool
    func editActionsForRowAt(indexPath: IndexPath, tableView: UITableView) -> [UITableViewRowAction]?
    
    //switch state methods
    func setSwitchState(to state: Bool)
    
    //flag state methods
    func setFlagState(to state: Bool)
    
    //reload tableView
    func reloadTableView()
    
    func pushCreateAndEditContactVC()
    
    func refetchData()
}

// MARK: - (Presenter -> View) presenter will update the view
protocol PresenterToViewContactListProtocol: AnyObject {
//    var presenter: ViewToPresenterContactListProtocol? { get set }
    
    func showActivityIndicator()
    func hideActivityIndicator()
    
    func makeAddButtonAppear()
    func makeAddButtonDisAppear()
    
    func reloadTableView()
    
    func reloadTableViewRows(at indexpaths: [IndexPath], with rowAnimation: UITableView.RowAnimation)
    
    func onContactListFetchSuccess()
    func onContactListFetchFailure(error: String)
}





// MARK: - (Presenter -> Interactor) presenter will ask for data to interactor
protocol PresenterToInteractorContactListProtocol: AnyObject {
    
    var presenter: InteractorToPresenterContactListProtocol? { get set }
    var contactsList: [ContactInfo] { get set }
    
    func fetchContactsFromZC()
    func fetchContactImages()
    
    func clearCache()
}

// MARK: - (Interactor -> Presenter) interactor will give data to the presenter
protocol InteractorToPresenterContactListProtocol: AnyObject {
    var interactor: PresenterToInteractorContactListProtocol? { get set }
    
    func getTotalNoOfcontacts() -> Int
    
    func onSingleContactFetchSuccess(contact: ContactInfo)
    
    func contactListFetchSuccess(contacts: [ContactInfo])
    func contactListFetchFailure(error: String)
    
    func imageFetchSuccess(contactImage: UIImage, at index: Int)
    
}









// MARK: - (Presenter -> Router)
protocol PresenterToRouterContactListProtocol: AnyObject {
    static func createModule() -> UINavigationController
    
    func pushIndividualContactDetail(on view: PresenterToViewContactListProtocol?, with contactInfo: ContactInfo)
    func pushCreateContactView(on view: PresenterToViewContactListProtocol?)
}

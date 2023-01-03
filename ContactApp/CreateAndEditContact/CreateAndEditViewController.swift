//
//  CreataAndEditViewController.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import UIKit

class CreateAndEditViewController: UITableViewController {

    var presenter: (ViewToPresenterCreateAndEditContactProtocol & InteractorToPresenterCreateAndEditContactProtocol)?
    
    let loadingViewController = LoadingViewController.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCreateAndEditViewController()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    
    
    
    
    // MARK: To configure this view as create contact view
    public func configureAsCreateContactView() {
        presenter?.setIsEditView(to: false)
    }
    
    // MARK: To configure this view as edit contact view
    public func configureAsEditContactView() {
        presenter?.setIsEditView(to: true)
    }
    
    
    
    private func setUpCreateAndEditViewController() {
        overrideUserInterfaceStyle = .light
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSaveButtonTapped))
        
        configureTableView()
    }
    
    private func configureTableView() {
        setTableViewDelegates()
        tableView.insetsContentViewsToSafeArea = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(CreateContactImgCell.self, forCellReuseIdentifier: CreateContactImgCell.cellIdentifier)
        tableView.register(LabelAndTextFieldCell.self, forCellReuseIdentifier: LabelAndTextFieldCell.cellIdentifier)
        tableView.register(NotesTextViewCell.self, forCellReuseIdentifier: NotesTextViewCell.cellIdentifier)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    

}


extension CreateAndEditViewController: PresenterToViewCreateAndEditContactProtocol {
    
    func setViewTitle(title: String) {
        self.title = title
    }
    
    func present(viewControllerToPresent: UIViewController, animated flag: Bool) {
        self.present(viewControllerToPresent, animated: flag)
    }
    
    func showLoadingScreen() {
        loadingViewController.modalPresentationStyle = .overCurrentContext
        loadingViewController.modalTransitionStyle = .crossDissolve
        
        self.present(loadingViewController, animated: true)
    }
    
    func dismissLoadingScreen() {
        loadingViewController.dismiss(animated: true)
    }
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        return tableView.cellForRow(at: indexPath)
    }
    
    func endEditing(_ force: Bool) {
        self.view.endEditing(force)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }

        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }
    
    func showAlertWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "OK", style: .default) { [self] (action:UIAlertAction!) in
            
            guard let navigationController = navigationController else { return }
            presenter?.returnToContactListScreen(navController: navigationController)
            
        }

        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }
    
}


// MARK: Table view delegates
extension CreateAndEditViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.setCellForRowAt(indexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath, tableView: tableView)
    }
}

extension CreateAndEditViewController {
    @objc private func onSaveButtonTapped() {
        presenter?.saveButtonTapped()
    }
}

//
//  ContactListViewController.swift
//  ContactApp
//
//  Created by rishab-13586 on 27/12/22.
//

import UIKit

class ContactListViewController: UITableViewController {

    var presenter: (ViewToPresenterContactListProtocol & InteractorToPresenterContactListProtocol)?
    
    let activityIndicator = {
        let activityIndicator1 = UIActivityIndicatorView(style: .medium)
        
        activityIndicator1.hidesWhenStopped = true
        
        return activityIndicator1
    } ()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Images.addLabel, for: .normal)
        return button
    } ()
    private let switchView: UISwitch = UISwitch()
    
    
    public func getAddButton() -> UIButton {
        return addButton
    }
    
    public func refreshScreen() {
        presenter?.refetchData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpContactListViewController()
        
        presenter?.setFlagState(to: true)
        presenter?.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        presenter?.viewWillAppear()
    }
    
    
    private func setUpContactListViewController() {
        overrideUserInterfaceStyle = .light
        
        switchView.addTarget(self, action: #selector(didSwitchStateChange), for: .valueChanged)
        let barBtn = UIBarButtonItem(customView: switchView)
        navigationItem.leftBarButtonItem = barBtn
        
        title = "My Contacts"

        configureTableView()
        
        setAddButtonConstrainsts()
        setActivityIndicatorConstraints()
        
        configureAddButton()
    }
    
    private func configureTableView() {
        setTableViewDelegates()
        
        tableView.addSubview(activityIndicator)
        
        tableView.insetsContentViewsToSafeArea = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(ContactInfoCell.self, forCellReuseIdentifier: ContactInfoCell.cellIdentifier)
        tableView.register(LargeTileContactinfoCell.self, forCellReuseIdentifier: LargeTileContactinfoCell.cellIdentifier)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureAddButton() {
        addButton.layer.cornerRadius = 64 / 2
        addButton.clipsToBounds = true
        addButton.layer.masksToBounds = true
        addButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
    }
    
    private func setAddButtonConstrainsts() {
        guard let navigationController = self.navigationController else { return }
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.bottomAnchor.constraint(equalTo:navigationController.view.bottomAnchor, constant: -30).isActive = true
        addButton.centerXAnchor.constraint(equalTo: navigationController.view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true
    }
    
    private func setActivityIndicatorConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -12)
        ])
    }

}


extension ContactListViewController: PresenterToViewContactListProtocol {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }

        alertController.addAction(OKAction)

        self.present(alertController, animated: true)
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func makeAddButtonAppear() {
        self.navigationController?.view.addSubview(addButton)
        setAddButtonConstrainsts()
    }
    
    func makeAddButtonDisAppear() {
        addButton.removeFromSuperview()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadTableViewRows(at indexpaths: [IndexPath], with rowAnimation: UITableView.RowAnimation) {
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: indexpaths, with: rowAnimation)
        }
    }
    
    
    func onContactListFetchSuccess() {
        // reload tableview to reflect the changes in it
        reloadTableView()
    }
    
    func onContactListFetchFailure(error: String) {
        print(error)
    }

}

// MARK: - TableView delegate methods
extension ContactListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.setCellForRowAt(indexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath, tableView: tableView)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return presenter?.canEditRowAt(indexPath: indexPath, tableView: tableView) ?? true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return presenter?.editActionsForRowAt(indexPath: indexPath, tableView: tableView)
    }
    
}


extension ContactListViewController {
    
    @objc private func didSwitchStateChange(_ sender: UISwitch) {
        if sender.isOn {
            presenter?.setSwitchState(to: true)
        }
        else {
            presenter?.setSwitchState(to: false)
        }
        presenter?.reloadTableView()
    }
    
}


extension ContactListViewController {
    @objc private func onButtonTap() {
        makeAddButtonDisAppear()
        presenter?.setFlagState(to: false)
        presenter?.pushCreateAndEditContactVC()
    }
}

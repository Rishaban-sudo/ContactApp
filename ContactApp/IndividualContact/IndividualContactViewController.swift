//
//  IndividualContactViewController.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import UIKit

class IndividualContactViewController: UITableViewController {

    var presenter: (ViewToPresenterIndividualContactProtocol & InteractorToPresenterIndividualContactProtocol)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpIndividualContactViewController()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        presenter?.viewWillAppear()
    }
    
    private func setUpIndividualContactViewController() {
        overrideUserInterfaceStyle = .light
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(onDeleteButtonTap)),
                                              UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(onEditButtonTap))]
        configureTableView()
    }
    
    private func configureTableView() {
        setTableViewDelegates()
        tableView.insetsContentViewsToSafeArea = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(ImgContainerCell.self, forCellReuseIdentifier: ImgContainerCell.cellIdentifier)
        tableView.register(ContactInfoContainerCell.self, forCellReuseIdentifier: ContactInfoContainerCell.cellIdentifier)
        tableView.register(NotesContainerCell.self, forCellReuseIdentifier: NotesContainerCell.cellIdentifier)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension IndividualContactViewController: PresenterToViewIndividualContactProtocol {
    
    func presentPopUpView(view: UIViewController, animated: Bool) {
        self.present(view, animated: animated)
    }
    
}


// MARK: - TableView delegate methods
extension IndividualContactViewController {
    
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

extension IndividualContactViewController {
    
    @objc private func onEditButtonTap() {
        presenter?.editButtonTapped()
    }
    
    @objc private func onDeleteButtonTap() {
        presenter?.deleteButtonTapped()
    }
    
}

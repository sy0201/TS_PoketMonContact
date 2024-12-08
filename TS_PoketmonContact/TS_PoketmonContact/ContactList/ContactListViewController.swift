//
//  ContactListViewController.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit

final class ContactListViewController: UIViewController {
    let contactListView = ContactListView()
    
    
    override func loadView() {
        super.loadView()
        view = contactListView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "친구 목록"
        
        // 오른쪽 바 버튼 설정
        let navRightItem = UIBarButtonItem(title: "추가",
                                           style: .plain,
                                           target: self,
                                           action: #selector(addButtonTapped))
        navRightItem.tintColor = .gray
        navigationItem.rightBarButtonItem = navRightItem
    }
    
    @objc func addButtonTapped() {
        print("추가버튼 탭")
    }
}

// MARK: - Private Method

private extension ContactListViewController {
    func setupTableView() {
        contactListView.tableView.dataSource = self
        contactListView.tableView.delegate = self
        
        // 셀 연결
        contactListView.tableView.register(ContactListTVCell.self, forCellReuseIdentifier: ContactListTVCell.reuseIdentifier)
    }
}

// MARK: - Tableview Method

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTVCell.reuseIdentifier, for: indexPath) as? ContactListTVCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

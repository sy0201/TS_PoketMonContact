//
//  ContactListViewController.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit

final class ContactListViewController: UIViewController {
    let contactViewModel = ContactViewModel()
    let contactListView = ContactListView()
    
    
    override func loadView() {
        super.loadView()
        view = contactListView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNetworkStatus()
        setupNavigationBar()
        setupTableView()
        
        // 연락처 데이터 로드
        contactViewModel.loadContacts()
        contactListView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 데이터를 로드하고 새로 고침
        contactViewModel.loadContacts()
        contactListView.tableView.reloadData()
    }

    func setupNavigationBar() {
        // UINavigationBarAppearance 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명한 기본 배경 설정
        appearance.backgroundColor = .white        // 원하는 배경색으로 설정
        appearance.shadowColor = nil               // 밑줄(쉐도우) 제거
        appearance.shadowImage = UIImage()         // 쉐도우 이미지 제거
        
        // 네비게이션 바에 appearance 적용
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 왼쪽 바 버튼 설정
        let navLeftItem = UIBarButtonItem(title: "Back",
                                          style: .plain,
                                          target: self,
                                          action: nil)
        // 오른쪽 바 버튼 설정
        let navRightItem = UIBarButtonItem(title: "추가",
                                           style: .plain,
                                           target: self,
                                           action: #selector(addButtonTapped))
        navRightItem.tintColor = .gray
        navigationItem.backBarButtonItem = navLeftItem
        navigationItem.rightBarButtonItem = navRightItem
        navigationItem.title = "친구 목록"
    }
    
    @objc func addButtonTapped() {
        let contactInfoController = PhoneBookViewController(contactViewModel: contactViewModel, mode: .add)
        navigationController?.pushViewController(contactInfoController, animated: true)
    }
}

// MARK: - Private Method

private extension ContactListViewController {
    func setupTableView() {
        contactListView.tableView.dataSource = self
        contactListView.tableView.delegate = self
        
        // 셀 연결
        contactListView.tableView.register(ContactListTVCell.self, forCellReuseIdentifier: ContactListTVCell.reuseIdentifier)
        
        contactListView.tableView.register(EmptyTVCell.self, forCellReuseIdentifier: EmptyTVCell.reuseIdentifier)
    }
}

// MARK: - Tableview Method

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = contactViewModel.contactList.count
        if count == 0 {
            return 1
        }
        return contactViewModel.contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if contactViewModel.contactList.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.reuseIdentifier, for: indexPath) as? EmptyTVCell else {
                return UITableViewCell()
            }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTVCell.reuseIdentifier, for: indexPath) as? ContactListTVCell else {
            return UITableViewCell()
        }
        
        let contactData = contactViewModel.contactList[indexPath.row]
        cell.configure(profile: contactData.profileImage ?? "", name: contactData.name ?? "", phoneNumber: contactData.phoneNumber ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contactViewModel.contactList[indexPath.row]
        
        let contactInfoController = PhoneBookViewController(contactViewModel: contactViewModel, selectedContact: selectedContact, mode: .edit)
        navigationController?.pushViewController(contactInfoController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (_, _, completionHandler) in
            // 삭제할 연락처 가져오기
            let contactToDelete = self.contactViewModel.contactList[indexPath.row]
            
            // Core Data에서 연락처 삭제
            self.contactViewModel.deleteContact(contact: contactToDelete)
            
            // TableView에서 해당 행 삭제
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

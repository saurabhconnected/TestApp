//
//  HomeViewModel.swift
//  TestApp
//
//  Created by Saurabh Shukla on 22/08/22.
//

import Foundation

protocol HomeViewModelProtocal {
    func fetchUsers()
    var onUserListDidUpdate: (() -> Void)? { get set }
    var userList: [HomeUser] { get set }
}

class HomeViewModel: HomeViewModelProtocal {
    var onUserListDidUpdate: (() -> Void)?
    var userList = [HomeUser]() {
        didSet {
            onUserListDidUpdate?()
        }
    }
    
    func fetchUsers() {
        NetworkManager.fetchUserList { result in
            DispatchQueue.main.async {[weak self] in
                switch result {
                case .success(let users):
                    self?.userList = users
                default:
                    self?.userList = []
                }
            }
        }
    }
}

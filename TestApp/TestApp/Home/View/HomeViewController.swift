//
//  HomeViewController.swift
//  TestApp
//
//  Created by Saurabh Shukla on 22/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelProtocal!
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onUserListDidUpdate = {[weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        viewModel.fetchUsers()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "homeTableCell")
        
        let user = viewModel.userList[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = "\(user.address.suite), \(user.address.street), \(user.address.city)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapVC.viewModel = MapViewModel()
        mapVC.viewModel.address = viewModel.userList[indexPath.row].address
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
}

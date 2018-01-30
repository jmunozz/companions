//
//  FavorisTableViewController.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/23/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import UIKit

class FavorisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoris: [Favoris] = []
    var tabBar: TabBarViewController? = nil
    var apiManager: APIRequests = APIRequests.getAPIManager()
    var hasSelectedRow: Bool = false
    
    let favorisTableView: ResultTableView = {
        let r = ResultTableView()
        r.translatesAutoresizingMaskIntoConstraints = false
        return r
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set table View
        self.favorisTableView.delegate = self
        self.favorisTableView.dataSource = self
        self.favorisTableView.register(FavCell.self, forCellReuseIdentifier: "favCell")
        
        setViews()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.hasSelectedRow == false {
            self.hasSelectedRow = true
            let i = favoris[indexPath.row].id
            let id = Int(i)
            self.apiManager.getUserById(id: id) { user in
                DispatchQueue.main.async {
                    if user != nil {
                        let loginView = LoginViewController()
                        loginView.tabBar = self.tabBar
                        loginView.favorisManager = self.tabBar!.favorisManager
                        loginView.user = user
                        let black = UIColor(red:0.16, green:0.18, blue:0.22, alpha:1.0)
                        loginView.view.backgroundColor = black
                        self.hasSelectedRow = false
                        self.navigationController?.pushViewController(loginView, animated: true)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoris.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavCell
        cell.profile = self.favoris[indexPath.row]
        return cell
    }
    
    func setViews() {
        
        self.view.addSubview(favorisTableView)
        
        favorisTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        favorisTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        favorisTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        favorisTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        
    }
}



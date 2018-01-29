//
//  FavorisTableViewController.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/23/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import UIKit

class FavorisTableViewController: UITableViewController {
    
    var favoris: [Favoris] = []
    let cellId = "favCell"
    var tabBar: TabBarViewController? = nil
    var apiManager: APIRequests = APIRequests.getAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FavCell.self, forCellReuseIdentifier: self.cellId)
        let black = UIColor(red:0.16, green:0.18, blue:0.22, alpha:1.0)
        self.tableView.backgroundColor = black
        let footer = UIView()
        footer.backgroundColor = black
        self.tableView.tableFooterView = footer
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
                    self.navigationController?.pushViewController(loginView, animated: true)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoris.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! FavCell
        cell.profile = self.favoris[indexPath.row]
        return cell
    }
}

class FavCell: UITableViewCell {
    
    var profile: Favoris? = nil {
        didSet {
            login.text = profile!.login
        }
    }
    
    let login: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor(red:0.12, green:0.73, blue:0.73, alpha:1.0)
        l.font = UIFont(name: l.font.fontName, size: 40)
        return l
    }()
    
    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        setViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        let blue = UIColor(red:0.12, green:0.73, blue:0.73, alpha:1.0).cgColor
        let black = UIColor(red:0.16, green:0.18, blue:0.22, alpha:1.0)
        self.layer.borderColor = blue
        self.layer.borderWidth = 1.0
        self.backgroundColor = black

        self.addSubview(login)
        login.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        login.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        login.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
}

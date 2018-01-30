//
//  ViewController.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/22/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//




import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserCell
        cell.user = self.results[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let user = self.results[indexPath.row]
            self.search.text = user.login
            self.changeButtonConstraint(false)
            self.lastCompletion = true
        }
    }
    
    
    var buttonTopConstraint1: NSLayoutConstraint? = nil
    var buttonTopConstraint2: NSLayoutConstraint? = nil
    var lastCompletion: Bool = false
    var results: [User] = []
    let apiManager: APIRequests = APIRequests.getAPIManager()
    var tabBar: TabBarViewController? = nil
    let search = UISearchBar()
    let indicator : UIActivityIndicatorView = {
        let i = UIActivityIndicatorView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.activityIndicatorViewStyle = .whiteLarge
        return i
    }()
    
    let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.white
        l.text = "Please enter a login"
        l.font = UIFont(name: l.font.fontName, size: 15)
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    
    
    let mainView:  UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(patternImage: UIImage(named: "background1")!)
        v.isUserInteractionEnabled = true
        return v
    }()
    
    let resultTable: ResultTableView = {
        let t = ResultTableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isUserInteractionEnabled = true
        return t
    }()
    
    let button: UIButton = {
        let green = UIColor(red:0.22, green:0.67, blue:0.39, alpha:1.0)
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = green
        b.setTitle("Search!", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 12
        b.addTarget(self, action: #selector(SearchButtonClicked), for: .touchUpInside)
        return b
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set NavigationBar settings
        self.navigationItem.title = "Search"
        
        // Instanciate Search Bar
        search.translatesAutoresizingMaskIntoConstraints = false
        search.isTranslucent = false
        search.barTintColor = UIColor(red:0.16, green:0.18, blue:0.22, alpha:1.0)
        search.delegate = self
        
        //Authenticate
        self.apiManager.authenticate()
        
        // Set table results
        self.resultTable.delegate = self
        self.resultTable.dataSource = self
        self.resultTable.register(UserCell.self, forCellReuseIdentifier: "userCell")
        setViews()
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissTable))
//        self.mainView.addGestureRecognizer(tap)
    }
    
    func setViews() {
        let black = UIColor(red:0.16, green:0.18, blue:0.22, alpha:1.0)
        self.view.backgroundColor = black
        
        // Set MainView
        self.view.addSubview(mainView)
        self.mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.mainView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.mainView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.mainView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        // Set searchBar
        self.mainView.addSubview(search)
        self.search.bottomAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.search.leftAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        self.search.rightAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        // Set label
        self.mainView.addSubview(label)

        self.label.centerXAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.search.topAnchor, constant: -7).isActive = true
        
        // Set indicator
        self.mainView.addSubview(indicator)
        self.indicator.topAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.indicator.bottomAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.centerYAnchor, constant: -10).isActive = true
        self.indicator.leftAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        self.indicator.rightAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        //Set resultTable
        self.mainView.addSubview(resultTable)
        self.resultTable.leftAnchor.constraint(equalTo: search.leftAnchor).isActive = true
        self.resultTable.rightAnchor.constraint(equalTo: search.rightAnchor).isActive = true
        self.resultTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.resultTable.heightAnchor.constraint(equalToConstant: 160).isActive = true
        self.resultTable.isHidden = true
        
        // Set Button
        self.mainView.addSubview(button)
        self.buttonTopConstraint1 = self.button.topAnchor.constraint(equalTo: self.mainView.centerYAnchor, constant: 15)
        self.buttonTopConstraint2 = self.button.topAnchor.constraint(equalTo: self.resultTable.bottomAnchor, constant: 15)
        self.buttonTopConstraint1?.isActive = true
        self.buttonTopConstraint2?.isActive = false
        self.button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let login = searchBar.text?.lowercased() {
            search(login)
        }
    }
    
    func search(_ login: String) {
        DispatchQueue.main.async {
            self.indicator.startAnimating()
            self.apiManager.getUserByLogin(login: login) { user in
                DispatchQueue.main.async {
                    if user != nil {
                        let loginView = LoginViewController()
                        loginView.user = user
                        loginView.tabBar = self.tabBar
                        loginView.favorisManager = self.tabBar!.favorisManager
                        let black = UIColor(red:0.16, green:0.18, blue:0.22, alpha:1.0)
                        loginView.view.backgroundColor = black
                        self.navigationController?.pushViewController(loginView, animated: true)
                    }
                    self.indicator.stopAnimating()
                }
            }
        }
    }
    
    @objc func SearchButtonClicked() {
        print("Button Clicked")
        if let login = search.text?.lowercased() {
            search(login)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.lastCompletion == true {
            self.lastCompletion = false
            return
        }
        
        if searchText == "" {
            changeButtonConstraint(false)
        } else {
            let login = searchText
            apiManager.getUserRangeByLogin(login: login) { users in
                if users != nil {
                    print(users!)
                    DispatchQueue.main.async {
                        self.changeButtonConstraint(true)
                        self.results = users!
                        self.resultTable.reloadData()
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        changeButtonConstraint(false)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("FINISHHHHH")
    }
    
    func changeButtonConstraint(_ toggled: Bool ) {
        if toggled == true {
            self.buttonTopConstraint1?.isActive = false
            self.buttonTopConstraint2?.isActive = true
        } else {
            self.buttonTopConstraint1?.isActive = true
            self.buttonTopConstraint2?.isActive = false
        }
        self.mainView.setNeedsLayout()
        self.resultTable.isHidden = (toggled == true) ? false : true
        
    }
    
}

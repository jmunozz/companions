//
//  TabBarViewController.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/23/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let favorisManager = FavorisManager()
    let fav: FavorisTableViewController = FavorisTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate search view with its own Navigation Controller
        let search = MainViewController()
        let searchNav = UINavigationController(rootViewController: search)
        searchNav.tabBarItem = UITabBarItem(tabBarSystemItem: .search,  tag: 0)
        search.tabBar = self

        // Instantiate fav view with its own Navigation Controller
        let favNav = UINavigationController(rootViewController: self.fav)
        fav.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites,  tag: 1)
        fav.tabBar = self
        refreshFavorisTabView()

        setViewControllers([searchNav, favNav], animated: true)
    }
    
    func refreshFavorisTabView() {
        self.fav.favoris = favorisManager.getAllFavoris()
        self.fav.tableView.reloadData()
    }
    
}



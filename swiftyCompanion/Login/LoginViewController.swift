//
//  LoginViewController.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/22/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: User? = nil {
        didSet {
            print(user!.id)
            if user!.image_url != nil {
                if let url = URL(string: user!.image_url!) {
                    do {
                        try  image.image = UIImage(data: Data(contentsOf:url))
                    } catch {
                        print("Impossible to load image")
                    }
                }
            }
            //Update login
            if user!.login != nil {
                login.text = user!.login!
            }
            // Update fullname
            if user!.displayname != nil {
                fullname.text = user!.displayname!
            }
            // Update phone
            if user!.phone != nil {
                phone.text = user!.phone!
            }
            // Update email
            if user!.email != nil {
                email.text = user!.email!
            }
            // Update location
            if user!.location != nil {
                location.text = user!.location
            }
            // Update level
            if user!.cursus_users != nil, user!.cursus_users!.count > 0 {
                if let l = user!.cursus_users![0].level {
                    level.text = l .cleanValue + " - " + l.afterCommaPercentValue + "%"
                    progress.setProgress(l.afterCommaValue, animated: true)
                }
            }
            // Update wallet
            if user!.wallet != nil {
                wallet.text = "Wallet - " + String(describing: user!.wallet!)
            }
            // Update projects
            if user!.projects_users != nil {
                self.projects = user!.projects_users!
            }
            // Update skills
            if user!.cursus_users != nil, user!.cursus_users!.count > 0 {
                let cursus42: CursusUser = user!.cursus_users![0]
                if cursus42.skills != nil {
                    self.skills = cursus42.skills!
                }
            }
        }
    }
    
    var tabBar: TabBarViewController? = nil
    var favorisManager: FavorisManager? = nil
    var skills: [Skill] = []
    var projects: [Project] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView is SkillTableView {
            print("skills")
            return self.skills.count
        } else {
            print("projects")
            return self.projects.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView is SkillTableView {
            let skillCell = tableView.dequeueReusableCell(withIdentifier: "skillCell", for: indexPath) as! skillCell
            skillCell.skill = self.skills[indexPath.row]
            return skillCell
        } else {
            let projectCell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! projectCell
            projectCell.project = self.projects[indexPath.row]
            return projectCell
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView is ProjectTableView {
            let project = projects[indexPath.row]
            print(project)
        }
    }


    let fullname: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont(name: l.font.fontName, size: 25)
        l.textColor = UIColor.white
        l.text = "Unavailable"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let login: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.textColor = UIColor.white
        l.text = "Unavailable"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let phone: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white
        l.textAlignment = .right
        l.text = "Unavailable"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let wallet: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white
        l.textAlignment = .right
        l.text = "Wallet - 0"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let correction: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white
        l.textAlignment = .right
        l.text = "Unavailable"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let email: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.textColor = UIColor.white
        l.text = "Unavailable"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let buttonFav: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "star"), for: .normal)
        b.addTarget(self, action: #selector(toggleFavoris), for: .touchUpInside)
        b.contentHorizontalAlignment = .fill
        b.contentVerticalAlignment = .fill
        return b
    }()
    
    let image: RoundedView = {
        let l = RoundedView()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.image = UIImage(named: "portrait")
        l.contentMode = .scaleAspectFill
        l.clipsToBounds = true
        l.layer.borderWidth = 2.0
        l.layer.borderColor = UIColor.white.cgColor
        l.backgroundColor = UIColor.green
        return l
    }()
    
    let location: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor.white
        l.font = UIFont(name: l.font.fontName, size: 30)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let progress: UIProgressView = {
        let blue = UIColor(red:0.27, green:0.51, blue:0.85, alpha:1.0)
        let black = UIColor(red:0.18, green:0.20, blue:0.22, alpha:1.0)
        let p = UIProgressView(progressViewStyle: .default)
        p.translatesAutoresizingMaskIntoConstraints = false
        p.progress = 0.35
        p.layer.cornerRadius = 8
        p.layer.masksToBounds = true
        p.progressTintColor = blue
        p.trackTintColor = black
        return p
    }()
    
    let level: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.text = "Level: 0 - 0%"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let skillsTable: SkillTableView = {
        let t = SkillTableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.tableFooterView = UIView()
        return t
        
    }()
    
    let projectTable: ProjectTableView = {
        let t = ProjectTableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.tableFooterView = UIView()
        return t
    }()
    
    let scroll: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.isUserInteractionEnabled = true
        return s
    }()
    
    let container: UIView = {
        let s = UIView()
        s.isUserInteractionEnabled = true
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView settings
        self.skillsTable.delegate = self
        self.skillsTable.dataSource = self
        self.skillsTable.register(skillCell.self, forCellReuseIdentifier: "skillCell")
        
        self.projectTable.delegate = self
        self.projectTable.dataSource = self
        self.projectTable.register(projectCell.self, forCellReuseIdentifier: "projectCell")
        
        
        self.view.backgroundColor = UIColor.white
        
        
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        view.isUserInteractionEnabled = true
        let stack = UIStackView(arrangedSubviews: [login, phone, email, wallet])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(image)
        
        image.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        view.addSubview(fullname)
        
        fullname.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        fullname.rightAnchor.constraint(equalTo: image.rightAnchor).isActive = true
        fullname.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        view.addSubview(stack)
        
        stack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        stack.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 15).isActive = true
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        

        view.addSubview(progress)

        progress.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        progress.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        progress.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        progress.heightAnchor.constraint(equalToConstant: 15).isActive = true

        view.addSubview(level)

        level.bottomAnchor.constraint(equalTo: progress.topAnchor, constant: -10).isActive = true
        level.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(location)

        location.topAnchor.constraint(equalTo: fullname.bottomAnchor, constant: 15).isActive = true
        location.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true

        view.addSubview(buttonFav)

        buttonFav.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonFav.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonFav.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonFav.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 10).isActive = true
        
        self.view.addSubview(scroll)
        scroll.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scroll.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scroll.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        scroll.addSubview(container)
        container.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
        container.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: scroll.rightAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
        
        container.addSubview(view)
        
        view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 450).isActive = true
        view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        
        let section1 = sectionView(title: "Skills")
        container.addSubview(section1)
        
        section1.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        section1.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        section1.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        section1.heightAnchor.constraint(equalToConstant:250).isActive = true
        
        section1.addSubview(skillsTable)
        
        skillsTable.topAnchor.constraint(equalTo: section1.t.bottomAnchor, constant: 10).isActive = true
        skillsTable.leftAnchor.constraint(equalTo: section1.leftAnchor, constant: 15).isActive = true
        skillsTable.rightAnchor.constraint(equalTo: section1.rightAnchor, constant: -15).isActive = true
        skillsTable.bottomAnchor.constraint(equalTo: section1.bottomAnchor, constant: -15).isActive = true
        
        let section2 = sectionView(title: "Projects")
        container.addSubview(section2)
        
        section2.topAnchor.constraint(equalTo: section1.bottomAnchor).isActive = true
        section2.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        section2.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        section2.heightAnchor.constraint(equalToConstant: 250).isActive = true
        section2.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        
        section2.addSubview(projectTable)
        
        projectTable.topAnchor.constraint(equalTo: section2.t.bottomAnchor, constant: 10).isActive = true
        projectTable.leftAnchor.constraint(equalTo: section2.leftAnchor, constant: 15).isActive = true
        projectTable.rightAnchor.constraint(equalTo: section2.rightAnchor, constant: -15).isActive = true
        projectTable.bottomAnchor.constraint(equalTo: section2.bottomAnchor, constant: -15).isActive = true
        
        
        let isButtonActive = (isFavoris(id: self.user!.id!) != nil) ? true : false
        setButton(isButtonActive)
        
    }
    
    
    func setButton(_ highlighted: Bool) {
        let blue = UIColor(red:0.27, green:0.51, blue:0.85, alpha:1.0)
        let black = UIColor(red:0.18, green:0.20, blue:0.22, alpha:1.0)
        let button =  self.buttonFav
        button.tintColor = (highlighted == true) ? blue : black
    }
    
    func isFavoris(id: Int) -> Favoris? {
        
        let f = self.favorisManager!.getFavoris(withId: user!.id!)
        return (f.count != 0) ? f[0] : nil
    }
    
   @objc func toggleFavoris(){
        print("button pressed")
        
        // User is already a fav, delete it.
        if let f: Favoris = isFavoris(id: self.user!.id!) {
            self.favorisManager!.removeFavoris(favoris: f)
            self.setButton(false)
            print("User has been removed from favs.")
            // User is not a fav yet, add it.
        } else {
            let favoris: Favoris = self.favorisManager!.newFavoris()
            favoris.login = user!.login!
            favoris.id = Int32(user!.id!)
            self.setButton(true)
            print("User has been added to favs.")
        }
        self.favorisManager!.save()
        self.tabBar?.refreshFavorisTabView()
    }
    
}

//
//  UserCell.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/29/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    
    var user: User? = nil {
        didSet {
            if let uLogin = user!.login {
                login.text = uLogin
            }
        }
    }
    
    let login: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "login"
        l.textColor = UIColor(red:0.12, green:0.73, blue:0.73, alpha:1.0)
        l.textAlignment = .left
        l.font = UIFont(name: l.font.fontName, size: 18)
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

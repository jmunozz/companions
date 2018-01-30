//
//  FavCell.swift
//  swiftyCompanion
//
//  Created by Jordan Munoz on 30/01/2018.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import UIKit


class FavCell: UITableViewCell {
    
    var profile: Favoris? = nil {
        didSet {
            login.text = profile!.login
        }
    }
    
    let login: UILabel = {
        let blue = UIColor(red:0.12, green:0.73, blue:0.73, alpha:1.0)
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = blue
        l.font = UIFont(name: l.font.fontName, size: 35)
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
        
        let black = UIColor(red:0.16, green:0.18, blue:0.22, alpha:1.0)
        self.backgroundColor = black
        
        // Set login
        self.addSubview(login)
        login.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        login.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        login.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 7).isActive = true
        login.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -7).isActive = true
    }
}

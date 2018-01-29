//
//  SkillCell.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/29/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import UIKit


class skillCell: UITableViewCell {
    
    var skill: Skill? = nil {
        didSet {
            let skillName = skill!.name
            let skillLevel = skill!.level
            if skillName != nil, skillLevel != nil {
                self.skillNameAndLevel.text = skill!.name! + " - " + String(describing: skill!.level!)
                self.progressLevel.setProgress(skill!.level!.afterCommaValue, animated: true)
            }
        }
    }
    
    let skillNameAndLevel: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.font = UIFont(name: l.font.fontName, size: 20)
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let progressLevel: UIProgressView = {
        let blue = UIColor(red:0.27, green:0.51, blue:0.85, alpha:1.0)
        let black = UIColor(red:0.18, green:0.20, blue:0.22, alpha:1.0)
        let p = UIProgressView(progressViewStyle: .default)
        p.translatesAutoresizingMaskIntoConstraints = false
        p.layer.cornerRadius = 4
        p.layer.masksToBounds = true
        p.progressTintColor = blue
        p.trackTintColor = black
        return p
    }()
    
    
    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        setViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        
        self.addSubview(skillNameAndLevel)
        skillNameAndLevel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        skillNameAndLevel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        
        self.addSubview(progressLevel)
        progressLevel.topAnchor.constraint(equalTo: skillNameAndLevel.bottomAnchor, constant: 5).isActive = true
        progressLevel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        progressLevel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    }
}

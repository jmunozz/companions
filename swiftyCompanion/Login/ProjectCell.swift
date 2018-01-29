//
//  ProjectCell.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/29/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import UIKit

class projectCell: UITableViewCell {
    
    var project: Project? = nil {
        didSet {
            if project!.project != nil {
                if let pName = project!.project!.name {
                    self.projectName.text = pName
                }
                if project!.status == "finished" {
                    let pMark = (project!.final_mark != nil) ? project!.final_mark! : 0
                    self.projectMark.text = String(describing: pMark)
                    self.projectMark.textColor = (project!.validated == true) ? UIColor.green : UIColor.red
                } else {
                    self.projectMark.text = " - "
                    self.projectMark.textColor = UIColor.black
                }
            }
        }
    }
    
    var projectName: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.font = UIFont(name: l.font.fontName, size: 20)
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    
    var projectMark: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.font = UIFont(name: l.font.fontName, size: 15)
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.addSubview(projectName)
        self.addSubview(projectMark)
        
        projectName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 7).isActive = true
        projectName.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -7).isActive = true
        projectName.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 7).isActive = true
        projectName.rightAnchor.constraint(equalTo: projectMark.leftAnchor, constant: -7).isActive = true
        
        projectMark.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 7).isActive = true
        projectMark.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -7).isActive = true
        projectMark.rightAnchor.constraint(equalTo:self.safeAreaLayoutGuide.rightAnchor, constant: -7).isActive = true
    }
}

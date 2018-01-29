//
//  SectionView.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/29/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import UIKit


class sectionView: UIView {
    
    
    let t: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.black
        l.textAlignment = .right
        l.font = UIFont(name: l.font.fontName, size: 30)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    init(title: String) {
        self.t.text = title
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        setViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        self.addSubview(t)
        t.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        t.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
    }
    
}

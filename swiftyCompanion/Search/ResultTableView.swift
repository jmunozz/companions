//
//  ResultTableView.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/29/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import UIKit

class ResultTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        let black = UIColor(red:0.16, green:0.18, blue:0.22, alpha:1.0)
        let blue = UIColor(red:0.12, green:0.73, blue:0.73, alpha:1.0)
        self.backgroundColor = black
        self.separatorColor = blue
        self.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5)
        self.tableFooterView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

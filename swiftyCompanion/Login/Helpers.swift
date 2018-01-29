//
//  Helpers.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/29/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import UIKit



extension Float {
    
    // Return two first digits after comma
    var afterCommaValue: Float
    {
        return self.truncatingRemainder(dividingBy: 1)
    }
    
    // Return value before comma
    var cleanValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var afterCommaPercentValue: String {
        var result =  self.truncatingRemainder(dividingBy: 1) * 100
        result = result.rounded()
        return String(format: "%.0f", result)
    }
}


class SkillTableView: UITableView {
   
}

class ProjectTableView: UITableView {
    
}

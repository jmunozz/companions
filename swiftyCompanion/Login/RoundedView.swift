//
//  RoundedView.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/29/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation
import UIKit


class RoundedView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
    }
}


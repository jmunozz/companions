//
//  Favoris+CoreDataProperties.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/23/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//
//

import Foundation
import CoreData


extension Favoris {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favoris> {
        return NSFetchRequest<Favoris>(entityName: "Favoris")
    }

    @NSManaged public var login: String?
    @NSManaged public var id: Int32

}

//
//  PlaceCategory+CoreDataProperties.swift
//  fisu
//
//  Created by vm mac on 17/03/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PlaceCategory {

    @NSManaged var name: String?
    @NSManaged var places: NSSet?

}

//
//  Departments+CoreDataProperties.swift
//  DemoCoredata
//
//  Created by Abdul Hameed Mohamed Rizvi on 11/21/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//
//

import Foundation
import CoreData


extension Departments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Departments> {
        return NSFetchRequest<Departments>(entityName: "Departments")
    }

    @NSManaged public var dep_id: Int16
    @NSManaged public var dep_name: String?
    @NSManaged public var dep_description: String?

}

//
//  Records+CoreDataProperties.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-17.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//
//

import Foundation
import CoreData


extension Records {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Records> {
        return NSFetchRequest<Records>(entityName: "Records")
    }

    @NSManaged public var income: Int32
    @NSManaged public var expense: Int32
    @NSManaged public var date: NSDate?
    @NSManaged public var user: Users?

}

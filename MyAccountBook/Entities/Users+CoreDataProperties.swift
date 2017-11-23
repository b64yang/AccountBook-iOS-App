//
//  Users+CoreDataProperties.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-17.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var records: NSSet?

}

// MARK: Generated accessors for records
extension Users {

    @objc(addRecordsObject:)
    @NSManaged public func addToRecords(_ value: Records)

    @objc(removeRecordsObject:)
    @NSManaged public func removeFromRecords(_ value: Records)

    @objc(addRecords:)
    @NSManaged public func addToRecords(_ values: NSSet)

    @objc(removeRecords:)
    @NSManaged public func removeFromRecords(_ values: NSSet)

}

//
//  Record.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-29.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit
import CoreData

public class Record: NSManagedObject {
    
    class func deleteRecord( with username: String, recordName: String, recordAmount: Int, recordDate: String, in context: NSManagedObjectContext) throws {
        let user = try? User.fetchUser(with: username, in: context)
        
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        let predicateUser = NSPredicate(format: "user == %@", user!)
        let predicateRecordName = NSPredicate(format: "recordName == %@", recordName)
        let predicateRecordAmount = NSPredicate(format: "recordAmount == %d", Int32(recordAmount))
        let predicateRecordDate = NSPredicate(format: "recordDate == %@", recordDate)
        
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicateUser, predicateRecordName, predicateRecordAmount, predicateRecordDate])
        
        request.predicate = andPredicate
        request.fetchLimit = 1
        
        do {
            let match = try context.fetch(request)
            
            context.delete(match[0])
            
            try context.save()
            
        } catch {
            throw error
        }
    }
    
    class func fetchRecords( with username: String, in context: NSManagedObjectContext) throws -> [Record] {
        let user = try? User.fetchUser(with: username, in: context)
        
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        let predicateUser = NSPredicate(format: "user == %@", user!)
        
        request.predicate = predicateUser
        
        do {
            let matches = try context.fetch(request)
            if matches.count == 0 {
                print("count: \(matches.count)")
            }
            return matches
        } catch {
            throw error
        }
    }
    
    class func createRecord( for user: String, in context: NSManagedObjectContext, recordName: String, recordAmount: Int, seg: String, recordDate: String) -> Record {
        let newrecord = Record(context: context)
        newrecord.recordName = recordName
        newrecord.recordAmount = Int32(seg == "income" ? (recordAmount) : (-recordAmount))
        newrecord.recordDate = recordDate
        
        let recordUser = try? User.fetchUser(with: user, in: context)
        newrecord.user = recordUser
        
        return newrecord
        
    }
}

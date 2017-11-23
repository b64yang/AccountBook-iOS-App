//
//  User.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-25.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit
import CoreData

public class User: NSManagedObject {
    
    class func fetchUser( with username: String, in context: NSManagedObjectContext) throws -> User {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "username == %@", username)
        request.predicate = predicate
//        request.fetchLimit = 1
        
        do {
            let match = try context.fetch(request)
            if match.count > 1 {
                print("count: \(match.count)!!!")
                return match[0]
            }else {
                return match[0]
            }
        } catch {
            throw error
        }
    }
    
    class func userCanLogin( with username: String, and password: String, in context: NSManagedObjectContext) throws -> Bool {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let predicateUsername = NSPredicate(format: "username == %@", username)
        let predicatePassword = NSPredicate(format: "password == %@", password)
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicateUsername, predicatePassword])
        
        request.predicate = andPredicate
        request.fetchLimit = 1
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                print("count: \(matches.count)")
                assert(matches.count == 1, "User.userCanLogin() -- database inconsistency")
                return true
            }else {
                return false
            }
        } catch {
            throw error
        }
    }
    
    class func userExists( for username: String, in context: NSManagedObjectContext) throws -> Bool {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", username)
        request.fetchLimit = 1
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                print("count: \(matches.count)")
                assert(matches.count == 1, "User.userExists() -- database inconsistency")
                return true
            }else {
                return false
            }
        } catch {
            throw error
        }
    }
    
    class func creates(context: NSManagedObjectContext, username: String, password: String, name: String, age: Int32) -> User {
        let newuser = User(context: context)
        newuser.username = username
        newuser.password = password
        newuser.name = name
        newuser.age = age
        
        return newuser
    }
}

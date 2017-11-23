//
//  User.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-25.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit
import CoreData

class User: NSManagedObject {
    class func create(_ context: NSManagedObjectContext, username: String, password: String, name: String, age: Int) -> User {
        let newUser = User(context: context)
        newUser.username = username
        newUser.password = password
        newUser.name = name
        newUser.age = Int32(age)
        
        return newUser
    }
}


//
//  ShoppingListItem.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-31.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit
import CoreData

public class ShoppingListItem: NSManagedObject {
    class func creates(context: NSManagedObjectContext, itemName: String, itemPrice: Int16) -> ShoppingListItem {
        
        let newItem = ShoppingListItem(context: context)
        newItem.itemName = itemName
        newItem.itemPrice = itemPrice
        
        let itemUser = try? User.fetchUser(with: CurrentUserInfo.username, in: context)
        newItem.user = itemUser
        
        return newItem
    }
    class func fetchAll(in context: NSManagedObjectContext) -> [ShoppingListItem]? {
        let request: NSFetchRequest<ShoppingListItem> = ShoppingListItem.fetchRequest()
        
        let itemUser = try? User.fetchUser(with: CurrentUserInfo.username, in: context)
        let predicate = NSPredicate(format: "user == %@", itemUser!)
        
        request.predicate = predicate
        
        let matches = try! context.fetch(request)
        return matches
    }
    class func fetchItem( itemName: String, itemPrice: Int16?, in context: NSManagedObjectContext) -> ShoppingListItem {
        let request: NSFetchRequest<ShoppingListItem> = ShoppingListItem.fetchRequest()
        let predicateItemName = NSPredicate(format: "itemName == %@", itemName)
        let itemUser = try? User.fetchUser(with: CurrentUserInfo.username, in: context)
        let predicateItemUser = NSPredicate(format: "user == %@", itemUser!)
        if itemPrice != nil {
            let predicateItemPrice = NSPredicate(format: "itemPrice == %d", itemPrice!)
            
            let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicateItemUser, predicateItemName, predicateItemPrice])
            request.predicate = andPredicate
            request.fetchLimit = 1
            
            let match = try? context.fetch(request)
            
            return match![0]
        }
        else {
            let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicateItemUser, predicateItemName])
            
            request.predicate = andPredicate
            
            request.fetchLimit = 1
            
            let match = try? context.fetch(request)
            
            return match![0]
        }
    }
    class func deleteItem( with itemName: String, itemPrice: Int16, in context: NSManagedObjectContext) throws {
        let user = try? User.fetchUser(with: CurrentUserInfo.username, in: context)
        
        let request: NSFetchRequest<ShoppingListItem> = ShoppingListItem.fetchRequest()
        let predicateItemUser = NSPredicate(format: "user == %@", user!)
        let predicateItemName = NSPredicate(format: "itemName == %@", itemName)
        let predicateItemPrice = NSPredicate(format: "itemPrice == %d", itemPrice)
        
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicateItemUser, predicateItemName, predicateItemPrice])
        
        request.predicate = andPredicate
        request.fetchLimit = 1
        
        do {
            let match = try context.fetch(request)
            
            context.delete(match[0])
            try? context.save()
            
        } catch {
            throw error
        }
    }
    class func deleteAllItems( in context: NSManagedObjectContext) throws {
        let request: NSFetchRequest<ShoppingListItem> = ShoppingListItem.fetchRequest()
        let user = try? User.fetchUser(with: CurrentUserInfo.username, in: context)
        let predicateItemUser = NSPredicate(format: "user == %@", user!)
        request.predicate = predicateItemUser
        
        do {
            let matches = try context.fetch(request)
            for match in matches {
                context.delete(match)
            }
            try? context.save()
        } catch {
            throw error
        }
    }
    class func mapItemsToRecords(in context: NSManagedObjectContext) throws {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        let date = Date()
        let itemDate = dateFormatter.string(from: date)
        
        let request: NSFetchRequest<ShoppingListItem> = ShoppingListItem.fetchRequest()
        let user = try? User.fetchUser(with: CurrentUserInfo.username, in: context)
        let predicateItemUser = NSPredicate(format: "user == %@", user!)
        request.predicate = predicateItemUser
        
        do {
            let matches = try context.fetch(request)
            for match in matches {
                let _ = Record.createRecord(for: CurrentUserInfo.username, in: context, recordName: match.itemName!, recordAmount: Int(match.itemPrice), seg: "expense", recordDate: itemDate)
                //try? context.save()
            }
            try? context.save()
        } catch {
            throw error
        }
    }
}






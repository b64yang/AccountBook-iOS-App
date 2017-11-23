//
//  AlertCenter.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-25.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import Foundation
import UIKit

class AlertCenter {
    class func createAlert(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {(_) -> Void in alert.dismiss(animated: true, completion: nil)})
        alert.addAction(action)
        
        return alert
    }
    
    class func createLogoutAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            CurrentUserInfo.wantToLogout = true
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            CurrentUserInfo.wantToLogout = false
        }))
    
        return alert
    }
    
    class func createAddShoppingListItemAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Item Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Item Price"
            textField.keyboardType = .numberPad
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            if alert.textFields!.first!.text! != "", alert.textFields!.last!.text! != "" {
                let itemName = alert.textFields!.first!.text!
                let itemPrice = alert.textFields!.last!.text!
                let _ = ShoppingListItem.creates(context: PersistenceService.context, itemName: itemName, itemPrice: Int16(itemPrice)!)
                PersistenceService.saveContext()
                NotificationCenter.default.post(name: NSNotification.Name("DoneMappingOrAdding"), object: nil)
            }
        }
        alert.addAction(action)
        
        return alert
    }
    class func createShoppingListMapConfirmationAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Map the list", message: "This is going to clear the list!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            ShoppingListTVC.confirmMapping = false
        }))
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            ShoppingListTVC.confirmMapping = true
        }))
        return alert
    }
}

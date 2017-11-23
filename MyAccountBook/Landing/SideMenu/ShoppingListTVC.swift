//
//  ShoppingListTVC.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-31.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit

class ShoppingListTVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addItemPressed(_ sender: Any) {
        let alert = AlertCenter.createAddShoppingListItemAlert()
        present(alert, animated: true, completion: nil)
    }
    @IBAction func mapPressed(_ sender: Any) {
        let alert = AlertCenter.createShoppingListMapConfirmationAlert()
        present(alert, animated: true, completion: nil)
    }
    
    var listItems: [ShoppingListItem]? = [ShoppingListItem]()
    static var confirmMapping = false {
        didSet{
            if confirmMapping == true {
                try? ShoppingListItem.mapItemsToRecords(in: PersistenceService.context)
                try? ShoppingListItem.deleteAllItems(in: PersistenceService.context)
                NotificationCenter.default.post(name: NSNotification.Name("DoneMappingOrAdding"), object: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listItems = ShoppingListItem.fetchAll(in: PersistenceService.context)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableViewAfterMappingOrAdding), name: NSNotification.Name("DoneMappingOrAdding"), object: nil)
    }
    
    @objc func reloadTableViewAfterMappingOrAdding() {
        listItems = ShoppingListItem.fetchAll(in: PersistenceService.context)
        self.tableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ShoppingListTVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if listItems != nil {
            return listItems!.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ShoppingListCell
        
        cell.setItem(itemName: listItems![indexPath.row].itemName!, itemPrice:  listItems![indexPath.row].itemPrice)
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            try? ShoppingListItem.deleteItem(with: listItems![indexPath.row].itemName!, itemPrice: listItems![indexPath.row].itemPrice, in: PersistenceService.context)
            listItems?.remove(at: indexPath.row)
            self.tableView.reloadData()
         } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
}

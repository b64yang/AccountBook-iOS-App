//
//  ViewController.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-17.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit
import CoreData

class RecordsViewController: UIViewController {
    
    var names = [String]()
    var amounts = [Int]()
    var dates = [String]()
    var records = [Record]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // fetch records from core data
        records = try! Record.fetchRecords(with: CurrentUserInfo.username, in: PersistenceService.context)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyReusableCell")
        self.tableView.reloadData()
    }
    @IBAction func onPlusTapped(_ sender: Any) {
        
    }
    
//    func recordFilled(name: String, amount: Int, seg: String, date: String ) {
//        names.append(name)
//        dates.append(date)
//        if seg == "income" {
//            amounts.append(amount)
//        }else {
//            amounts.append(-amount)
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "onPlusTapped" {
            let destinationVC = segue.destination as! AddRecordsViewController
            //destinationVC.delegate = self
        }
    }
    
}

extension RecordsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return records.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        if indexPath.section == 0 {
            var totalPrice = 0
            for amount in amounts {
                totalPrice += amount
            }
            (cell as? RecordCell)?.setView(name: "Balance", amount: totalPrice > 0 ? "$: +\(totalPrice)" : String(totalPrice), date: "your total balance")
            return cell!
        }
        else if indexPath.section == 1 {
            (cell as? RecordCell)?.setView(name: records[indexPath.row].recordName!, amount: records[indexPath.row].recordAmount > 0 ? "$: +\(records[indexPath.row].recordAmount)" : "$: \(records[indexPath.row].recordAmount)", date: records[indexPath.row].recordDate!)
            return cell!
        }
        else {
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete, indexPath.section != 0 {
            // handle delete (by removing the data from your array and updating the tableview)
//            self.names.remove(at: indexPath.row)
//            self.amounts.remove(at: indexPath.row)
//            self.dates.remove(at: indexPath.row)
            do {
                try Record.deleteRecord(with: CurrentUserInfo.username, recordName: records[indexPath.row].recordName!, recordAmount: Int(records[indexPath.row].recordAmount), recordDate: records[indexPath.row].recordDate!, in: PersistenceService.context)
                //try? PersistenceService.context.save()
            }catch{
                print(error)
            }
            records.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}


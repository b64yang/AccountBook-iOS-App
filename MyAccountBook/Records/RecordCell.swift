//
//  RecordCell.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-17.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func setView(name: String, amount: String, date: String) {
        self.name!.text = name
        self.amount!.text = amount
        self.date!.text = date
    }
}

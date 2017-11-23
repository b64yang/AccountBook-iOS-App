//
//  ShoppingListCell.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-31.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit

class ShoppingListCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemPriceTF: UITextField!
    
    var itemNameTemp: String = ""
    var itemPriceTemp: Int16? = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemNameTF.delegate = self
        itemPriceTF.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("shouldBegin")
        if textField == itemNameTF {
            print("field==namefield")
            itemNameTemp = textField.text!
        }else{
            itemPriceTemp = Int16(textField.text!)
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        }else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let oldItem = ShoppingListItem.fetchItem(itemName: itemNameTemp, itemPrice: itemPriceTemp, in: PersistenceService.context)
        oldItem.itemName = itemNameTF.text
        oldItem.itemPrice = Int16(itemPriceTF.text!)!
        PersistenceService.saveContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        itemNameTF.endEditing(true)
        itemPriceTF.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    func setItem(itemName: String, itemPrice: Int16) {
        itemNameTF.text = itemName
        itemPriceTF.text = String(itemPrice)
        itemNameTemp = itemName
        itemPriceTemp = itemPrice
    }
    
    
    
}

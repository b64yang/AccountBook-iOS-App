//
//  AddViewController.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-17.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit

protocol recordPopulatedDelegate {
    func recordFilled(name: String, amount: Int, seg: String, date: String)
}

class AddRecordsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var moneyType: UISegmentedControl!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var delegate: recordPopulatedDelegate? = nil
    
    // edit did begin
    // create the datePicker with a done Button to end the editing
    @IBAction func dateEditing(_ sender: UITextField) {
        
        //create toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //create doneButton
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        //create datePicker and make it synched with dateTextField
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        // use this method to set the default date to dateTextField
        datePickerValueChanged(sender: datePickerView)
        
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
            if nameTextField.text != "", amountTextField.text != "", dateTextField.text != ""  {
                let recordName = nameTextField.text
                let recordAmount = Int(amountTextField.text!)
                let recordDate = dateTextField.text
                let seg = segmentedControl.selectedSegmentIndex == 0 ? "income" : "exspense"
                // need to fill in completion with core data function
                
                let _ = Record.createRecord(for: CurrentUserInfo.username, in: PersistenceService.context, recordName: recordName!, recordAmount: recordAmount!, seg: seg, recordDate: recordDate!)
                try? PersistenceService.context.save()
                print("done saving")
                
                delegate?.recordFilled( name: nameTextField.text!, amount: Int(amountTextField.text!)!,seg: (segmentedControl.selectedSegmentIndex == 0 ? "income" : "exspense"), date: dateTextField.text!)
                navigationController?.popViewController(animated: true)
            }
            else {
                let alert = AlertCenter.createAlert(title: "Missing Data", message: "One or more field unfilled")
                present(alert, animated: true, completion: nil)
            }
        
    }
    
    @IBAction func quitButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.amountTextField.keyboardType = .decimalPad
    }

}

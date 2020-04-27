//
//  ItemDetailTableViewController.swift
//  CGreeneSalesTrack
//
//  Created by Christopher Greene on 4/24/20.
//  Copyright © 2020 Christopher Greene. All rights reserved.
//

import UIKit


private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter
}()


var totalItems = 0
var totalValue = 0.0
var totalCost = 0.0
var averageCost = 0.0
var averageValue = 0.0
var profit = 0.0
var roi = 0.0


class ItemDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var sizeField: UITextField!
    
    @IBOutlet weak var skuField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var costField: UITextField!
    
    @IBOutlet weak var valueField: UITextField!
   
    
    var item: Items!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if item == nil {
            item = Items(name: "", size: "", sku: "", date: Date(), cost: 0.0, value: 0.0)
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        nameField.text = item.name
        sizeField.text = "\(item.size ?? "")"
        skuField.text = item.sku
        datePicker.date = item.date
        costField.text = "\(item.cost)"
        valueField.text = "\(item.value)"
        dateLabel.text = dateFormatter.string(from: item.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        item = Items(name: nameField.text, size: sizeField.text, sku: skuField.text, date: datePicker.date, cost: Double(costField.text ?? "")!, value: Double(valueField.text ?? "")!)
        totalItems += 1
        totalValue += Double(valueField.text!) ?? 0.00
        totalCost += Double(costField.text!) ?? 0.0
        averageCost = totalCost / Double(totalItems)
        averageValue = totalValue / Double(totalItems)
        profit = totalValue - totalCost
        roi = profit / totalCost
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        dateLabel.text = dateFormatter.string(from: sender.date)
    }
    
}

//
//  ViewController.swift
//  CGreeneSalesTrack
//
//  Created by Christopher Greene on 4/24/20.
//  Copyright © 2020 Christopher Greene. All rights reserved.
//

import UIKit


var itemCount: Int!
var itemURL = "https://stockx.com/search/s="

class ItemListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var itemArray: [Items] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        loadData()        
    }
    
    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("items").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            itemArray = try jsonDecoder.decode(Array<Items>.self, from: data)
            tableView.reloadData()
        } catch {
            print("Error: Could not load data; \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("items").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(itemArray)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("Error: Could not save data \(error.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! ItemDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.item = itemArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! ItemDetailTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            itemArray[selectedIndexPath.row] = source.item
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: itemArray.count, section: 0)
            itemArray.append(source.item)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveData()
        
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
        }
    }
    
    
    @IBAction func handleGesture(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began
        {
            let alertController = UIAlertController(title: nil, message:
                "Open Product in Safari", preferredStyle: .alert)
            let indexPath = tableView.indexPathForSelectedRow
            let itemSku = self.itemArray[indexPath?.row ?? 0].sku
            alertController.addAction(UIAlertAction(title: "Go to Safari", style: .default,handler: { action in
                UIApplication.shared.open(URL(string: "\(itemURL)\(itemSku ?? "")") ?? URL(string: "")!, options: [:]) { _ in
                print("Link opened")
            }
        }))
        
        present(alertController, animated: true, completion: nil)
    }
}

}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemCount = itemArray.count
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].name
        cell.textLabel?.font = UIFont(name:"Trebuchet MS", size:20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itemArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = itemArray[sourceIndexPath.row]
        itemArray.remove(at: sourceIndexPath.row)
        itemArray.insert(itemToMove, at: destinationIndexPath.row)
        saveData()
    }
}

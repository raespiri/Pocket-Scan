//
//  ItemHistoryTableViewController.swift
//  PocketScan
//
//  Created by Ryan Espiritu (raespiri@usc.edu) on 4/29/19.
//  Copyright © 2019 ITP 342. All rights reserved.
//

import UIKit

// Table View Controller to display previously scanned items
class ItemHistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Item History"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemModel.shared.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemHistoryTableViewCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = ItemModel.shared.items[indexPath.row].title

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ItemModel.shared.items.remove(at: indexPath.row)
            ItemModel.shared.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Present corresponding product list when an item cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "productTableViewController") as! ProductTableViewController
        productTableViewController.title = "Product List"
        productTableViewController.products = ItemModel.shared.items[indexPath.row].products
        self.navigationController?.pushViewController(productTableViewController, animated: true)
    }
    
    
    // MARK: - IBActions
    
    // Segue to dismiss self
    @IBAction func closeButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}

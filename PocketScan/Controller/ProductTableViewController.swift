//
//  ProductTableViewController.swift
//  PocketScan
//
//  Created by Ryan Espiritu (raespiri@usc.edu) on 4/27/19.
//  Copyright © 2019 ITP 342. All rights reserved.
//

import UIKit
import Kingfisher

// Table View Controller to display clickable product listings
class ProductTableViewController: UITableViewController {

    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productTableViewCell", for: indexPath) as! ProductTableViewCell

        // Configure the cell...
        cell.titleLabel.text = "\(products![indexPath.row].merchant) • $\(products![indexPath.row].price)"
        cell.descriptionLabel.text = products![indexPath.row].title
        cell.merchantImageView.kf.setImage(with: URL(string: "https://www.\(products![indexPath.row].domain)/favicon.ico"))
        
        return cell
    }
    
    // Present corresponding website when a product cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productWebKitViewController = self.storyboard?.instantiateViewController(withIdentifier: "productWebKitViewController") as! ProductWebKitViewController
        productWebKitViewController.title = products![indexPath.row].domain
        productWebKitViewController.productURL = products![indexPath.row].link
        self.navigationController?.pushViewController(productWebKitViewController, animated: true)
    }

}

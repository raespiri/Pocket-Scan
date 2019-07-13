//
//  BarcodeViewController.swift
//  PocketScan
//
//  Created by Ryan Espiritu (raespiri@usc.edu) on 4/27/19.
//  Copyright © 2019 ITP 342. All rights reserved.
//

import UIKit
import BarcodeScanner

// Intial view controller to scan barcodes
class BarcodeViewController: BarcodeScannerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.headerViewController.closeButton.isHidden = true
        self.codeDelegate = self
        
        self.isOneTimeSearch = true
        self.title = "Scan Barcode"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reset(animated: false)
    }

    // Displays alert that no matching products were found
    private func presentNoProductFoundAlert() {
        let alert = UIAlertController(title: "No Products Found", message: "Unable to find online products matching the corrresponding barcode", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            self.reset()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func historyButtonDidTap(_ sender: UIBarButtonItem) {
        
    }
}


// MARK: - BarcodeScannerCodeDelegate

extension BarcodeViewController: BarcodeScannerCodeDelegate {
    
    // Handle the captured code after scanning
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {        
        // API request to lookup UPC code
        ItemModel.shared.lookupUPC(code) { (error) in
            DispatchQueue.main.async() {
                if error != nil {
                    self.presentNoProductFoundAlert()
                    return
                }
                
                self.presentProductTableViewController()
            }
        }
    }
    
    // Helper function to present table view controller
    private func presentProductTableViewController() {
        let productTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "productTableViewController") as! ProductTableViewController
        productTableViewController.title = "Product List"
        productTableViewController.products = ItemModel.shared.items[ItemModel.shared.items.count-1].products
        self.navigationController?.pushViewController(productTableViewController, animated: true)
    }
    
}


// MARK: - BarcodeScannerCodeDelegate

extension BarcodeViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        presentNoProductFoundAlert()
        reset()
    }
}

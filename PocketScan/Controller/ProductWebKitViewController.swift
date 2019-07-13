//
//  ProductWebKitViewController.swift
//  PocketScan
//
//  Created by Ryan Espiritu (raespiri@usc.edu) on 4/28/19.
//  Copyright © 2019 ITP 342. All rights reserved.
//

import UIKit
import WebKit

// View Controller to house wkwebview and display websites to products
class ProductWebKitViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var productURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
        
        // Load product's webpage within app
        if let url = URL(string: productURL) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }

}


// MARK: - WKNavigationDelegate

extension ProductWebKitViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}


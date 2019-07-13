//
//  ItemModel.swift
//  PocketScan
//
//  Created by Ryan Espiritu (raespiri@usc.edu) on 4/27/19.
//  Copyright © 2019 ITP 342. All rights reserved.
//

import Foundation

let BASE_URL = "https://api.upcitemdb.com/prod/trial/lookup"
let ITEMS = "items"

// Represents the data model for item objects within the app
class ItemModel {
    
    static let shared = ItemModel()
    
    // Master list of all items
    var items = [Item]()

    init() {
        // Try getting back items from user defaults
        if let data = UserDefaults.standard.object(forKey: ITEMS) as? Data {
            if let items = try? JSONDecoder().decode([Item].self, from: data) {
                self.items = items
            }
        }
    }
    
    func lookupUPC(_ upc: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        
        // Make an API request to upcitemdb to get item info
        if let url = URL(string: "\(BASE_URL)?upc=\(upc)") {
            var urlRequest = URLRequest(url: url)
            
            // Set the Content-Type/Accepts Headers for json
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    completionHandler(error)
                    return
                }
                
                if let data = data {
                    // Decode data to JSON object
                    do {
                        // Create item object from JSON Data
                        guard let item = try JSONDecoder().decode(LookupResult.self, from: data).items.first else {
                            completionHandler(JSONDecoderError())
                            return
                        }
                        
                        // Add to items list and save model to defaults
                        // Remove previous duplicate if necessary
                        if let index = self.items.firstIndex(of: item){
                            self.items.remove(at: index)
                        }
                        self.items.append(item)
                        self.save()
                        
                        completionHandler(nil)
                    } catch let error {
                        completionHandler(error)
                    }
                }
            }.resume()
        }
    }
    
    // Saves current list of items to defaults
    func save() {
        if let items = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(items, forKey: ITEMS)
        }
    }
    
}

struct JSONDecoderError: Error {
    var localizedDescription: String { return "Unable to find online products matching the corrresponding barcode" }
}

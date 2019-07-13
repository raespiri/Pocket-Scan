//
//  Item.swift
//  PocketScan
//
//  Created by Ryan Espiritu (raespiri@usc.edu) on 4/27/19.
//  Copyright © 2019 ITP 342. All rights reserved.
//

import Foundation

// Object to represent item scanned via upc barcode
struct Item: Codable {
    var title: String
    var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case title
        case products = "offers"
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.title == rhs.title
    }
}

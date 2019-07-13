//
//  Product.swift
//  PocketScan
//
//  Created by Ryan Espiritu (raespiri@usc.edu) on 4/27/19.
//  Copyright © 2019 ITP 342. All rights reserved.
//

import Foundation

// Object to represent different product instances of a scanned item
class Product: Codable {
    var merchant: String
    var domain: String
    var title: String
    var price: Double
    var link: String
    
    enum CodingKeys: String, CodingKey {
        case merchant
        case domain
        case title
        case price
        case link
    }
}

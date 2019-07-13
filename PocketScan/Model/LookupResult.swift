//
//  LookupResult.swift
//  PocketScan
//
//  Created by Ryan Espiritu (raespiri@usc.edu) on 4/27/19.
//  Copyright © 2019 ITP 342. All rights reserved.
//

import Foundation

// Object to encapsulate top level json result from upc api
struct LookupResult: Codable {
    var items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

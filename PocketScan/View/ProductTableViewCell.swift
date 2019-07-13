//
//  ProductTableViewCell.swift
//  PocketScan
//
//  Created by Ryan Espiritu (raespiri@usc.edu) on 4/28/19.
//  Copyright © 2019 ITP 342. All rights reserved.
//

import UIKit

// Custum table view cell to display product listings
class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var merchantImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

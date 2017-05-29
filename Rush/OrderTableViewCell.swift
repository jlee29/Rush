//
//  OrderTableViewCell.swift
//  Rush
//
//  Created by Jiwoo Lee on 5/21/17.
//  Copyright © 2017 DolphinDevs. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var order: Order? {
        didSet {
            descLabel.text = order!.desc
            priceLabel.text = "\(order!.price)"
            locationLabel.text = "temp - fill in"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

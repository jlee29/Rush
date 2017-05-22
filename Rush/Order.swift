//
//  Order.swift
//  Rush
//
//  Created by Jiwoo Lee on 5/21/17.
//  Copyright © 2017 DolphinDevs. All rights reserved.
//

import Foundation

struct Order {
    var desc: String?
    var price: Double?
    var location: String?
    
    init(with orderDesc: String, orderPrice: Double, orderLocation: String) {
        desc = orderDesc
        price = orderPrice
        location = orderLocation
    }
}

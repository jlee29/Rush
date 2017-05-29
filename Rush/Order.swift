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
    var longitude: Double?
    var latitude: Double?
    
    init(with orderDesc: String, orderPrice: Double, orderLongitude: Double, orderLatitude: Double) { // the first "with" argument seems inconsistent...
        desc = orderDesc
        price = orderPrice
        longitude = orderLongitude
        latitude = orderLatitude
    }
}

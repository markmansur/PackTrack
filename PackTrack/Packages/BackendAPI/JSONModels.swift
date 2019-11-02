//
//  ShippoModels.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-17.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import Foundation

struct trackingResponse: Decodable {
    let expectedDelivery: String?
    let checkpoints: [checkpoint]?
    
    enum CodingKeys: String, CodingKey {
        case expectedDelivery = "expected_delivery"
        case checkpoints
    }
}

struct checkpoint: Decodable {
    let tag: String?
    let message: String?
    let time: String?
    let city: String?
    let state: String?
    let country: String?
    
    enum CodingKeys: String, CodingKey {
        case tag
        case message = "subtag_message"
        case time = "checkpoint_time"
        case city
        case state
        case country = "country_iso3"
    }
}

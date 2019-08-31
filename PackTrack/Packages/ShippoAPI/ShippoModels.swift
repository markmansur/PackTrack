//
//  ShippoModels.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-17.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import Foundation

struct trackingResponseJSON: Decodable {
    let eta: String?
    let trackingStatus: trackingStatusJSON?
    let trackingHistory: [trackingStatusJSON]?
}

struct trackingStatusJSON: Decodable {
    let status: String?
    let statusDetails: String?
    let statusDate: String?
    let location: locationJSON
}

struct locationJSON: Decodable {
    let city: String?
    let state: String?
    let zip: String?
    let country: String?
}

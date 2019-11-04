//
//  Carriers.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-11-02.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import Foundation

enum Carrier: String, CaseIterable {
    case ups = "UPS"
    case usps = "United States Postal Service"
    case canadaPost = "Canada Post"
    case fedex = "FedEx"
    case dhl = "DHL"
}

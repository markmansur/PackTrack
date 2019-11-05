//
//  ShippoService.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-17.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import Foundation

struct BackendService {
    static let shared = BackendService()
    
    // TODO: pass in and use carrier here
    func getTrackingInfo(for trackingNumber: String, carrier: String, completion: @escaping (trackingResponse?, Error?) -> Void) {
        var carrierCode: String?
        
        switch carrier {
        case Carrier.ups.rawValue:
            carrierCode = "ups"
        case Carrier.usps.rawValue:
            carrierCode = "usps"
        case Carrier.fedex.rawValue:
            carrierCode = "fedex"
        case Carrier.dhl.rawValue:
            carrierCode = "dhl"
        default:
            carrierCode = ""
        }
        
        let urlString = "http://localhost:5000/\(carrierCode ?? "")/\(trackingNumber)"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Failed to fetch json: ", error)
                completion(nil, error)
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let trackingInfo = try jsonDecoder.decode(trackingResponse.self, from: data)
                completion(trackingInfo, nil)
                
            } catch let decodeErr {
                print("Failed to decode json: ", decodeErr)
                completion(nil, decodeErr)
            }
        }.resume()
        
    }
     
}

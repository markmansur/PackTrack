//
//  ShippoService.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-17.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import Foundation

struct ShippoService {
    static let shared = ShippoService()
        
    func getTrackingInfo(for trackingNumber: String, completion: @escaping (trackingResponseJSON?, Error?) -> Void) {
//        let urlString = "https://api.goshippo.com/tracks/usps/\(trackingNumber)"
        let urlString = "http://localhost:5000"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
//        request.addValue("ShippoToken shippo_live_238bf56280928d9d3d7dfc6e65f7230d0367fefe", forHTTPHeaderField: "Authorization")
        

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Failed to fetch json: ", error)
                completion(nil, error)
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let trackingInfo = try jsonDecoder.decode(trackingResponseJSON.self, from: data)
                completion(trackingInfo, nil)
                
            } catch let decodeErr {
                print("Failed to decode json: ", decodeErr)
                completion(nil, decodeErr)
            }
        }.resume()
        
    }
     
}

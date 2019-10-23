//
//  GeocodingService.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-24.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import Foundation

struct GeocodingService {
    static let shared = GeocodingService()
    
    func getGeocode(city: String, state: String, country: String, completion: @escaping (Coordinate?, Error?) -> Void) {
        
        let addressString = "\(city)+\(state)+\(country)"
        
        var url = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json")
        let keyParam = URLQueryItem(name: "key", value: EnvironmentVariables.GOOGLE_API_KEY.value)
        let addressParam = URLQueryItem(name: "address", value: addressString)
        url?.queryItems = [keyParam, addressParam]
        
        URLSession.shared.dataTask(with: (url?.url)!) { (data, response, error) in
            if let error = error {
                print("Failed to fetch geocode json", error)
                completion(nil, error)
            }
            guard let data = data else {
                completion(nil, error)
                return
                
            }
            
            do {
                guard let json =  try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                guard let results = json["results"] as? [[String: Any]] else { return }
                guard let geometry = (results[0])["geometry"] as? [String: Any] else { return }
                guard let location = geometry["location"] as? [String: Double] else { return }
                
                guard let lat = location["lat"] else { return }
                guard let lng = location["lng"] else { return }
                let coordinate = Coordinate(latitude: lat, longitude: lng)
                completion(coordinate, nil)
            } catch let err {
                print(err.localizedDescription)
            }
            
            
        }.resume()
        
        
    }
}

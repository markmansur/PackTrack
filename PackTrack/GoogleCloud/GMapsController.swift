//
//  GMapsController.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-29.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit
import GoogleMaps

class GMapsController: UIViewController {
    var geolocations: [Geolocation]?
    
    init(geolocations: [Geolocation]?) {
        self.geolocations = geolocations
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: 39.111633, longitude: -94.637469, zoom: 5)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        
        do {
          // Set the map style by passing the URL of the local file.
          if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
          } else {
            NSLog("Unable to find style.json")
          }
        } catch {
          NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        mapView.layer.cornerRadius = 6
        self.view = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateMarkers()
    }
    
    private func updateMarkers() {
        (view as? GMSMapView)?.clear()
        
        var bounds = GMSCoordinateBounds()
        var markers = [GMSMarker]()
        
        geolocations?.forEach({ (geolocation) in
            let latitude = geolocation.latitude
            let longitude = geolocation.longitude
            
            print(latitude)
            print(longitude)
            
            var alreadyExists = false
            
            // check if marker has already been plotted
            markers.forEach { (marker) in
                let position = marker.position
                let markerLatitude = position.latitude
                let markerLongitude = position.longitude
                
                if markerLatitude == latitude && markerLongitude == longitude {
                    alreadyExists = true
                }
            }
            
            if !(alreadyExists == true) {
                let marker = GMSMarker()
                
                marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                marker.map = view as? GMSMapView
                bounds = bounds.includingCoordinate(marker.position)
                
                markers.append(marker)
            }
        })
        
        if markers.count != 1 {
            let update = GMSCameraUpdate.fit(bounds, withPadding: 40)
            (view as? GMSMapView)?.animate(with: update)
        } else {
            let cameraPosition = GMSCameraPosition(latitude: markers[0].position.latitude, longitude: markers[0].position.longitude, zoom: 9)
            (view as? GMSMapView)?.animate(to: cameraPosition)
        }
        
    }
    
    
}

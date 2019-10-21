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
        updateMarkers()
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
        
        mapView.isUserInteractionEnabled = false
        
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
        let markerImage = UIImage(named: "marker")
        let finalMarkerImage = UIImage(named: "marker-final")
        
        (view as? GMSMapView)?.clear()
        
        var bounds = GMSCoordinateBounds()
        var markers = [GMSMarker]()
        
        let path = GMSMutablePath()
        
        geolocations?.forEach({ (geolocation) in
            let latitude = geolocation.latitude
            let longitude = geolocation.longitude
            
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
                
                if (geolocation.isEqual(geolocations?.last)) {
                    marker.icon = finalMarkerImage
                } else {
                    marker.icon = markerImage
                }
                
                marker.isFlat = true
                marker.groundAnchor = CGPoint(x: 0.5, y: 0.5) // makes the centre of the image the 'tip' of the image that touches the earth
                
                let markerLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                path.add(markerLocation)
                
                marker.position = markerLocation
                marker.map = view as? GMSMapView
                bounds = bounds.includingCoordinate(marker.position)
                
                markers.append(marker)
            }
        })
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .customGreen
        polyline.strokeWidth = 2
        
        let styles = [GMSStrokeStyle.solidColor(.clear),
                      GMSStrokeStyle.solidColor(UIColor.customGreen.withAlphaComponent(0.75))]
        let lengths: [NSNumber] = [20000, 20000]
        polyline.spans = GMSStyleSpans(polyline.path!, styles, lengths, .rhumb)

        
        polyline.map = (view as? GMSMapView)
        
        if markers.count != 1 {
            let update = GMSCameraUpdate.fit(bounds, withPadding: 22)
            (view as? GMSMapView)?.animate(with: update)
        } else {
            let cameraPosition = GMSCameraPosition(latitude: markers[0].position.latitude, longitude: markers[0].position.longitude, zoom: 8)
            (view as? GMSMapView)?.animate(to: cameraPosition)
        }
        
    }
    
    
}

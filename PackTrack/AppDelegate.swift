//
//  AppDelegate.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-10.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

//     AIzaSyAPsCmI7Uh7JZPJWnpWx7s4y-xK22Uee4A

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyAPsCmI7Uh7JZPJWnpWx7s4y-xK22Uee4A")
        
        
        return true
    }
    
    
}


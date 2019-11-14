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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let googleAPIKey = EnvironmentVariables.GOOGLE_API_KEY.value {
            GMSServices.provideAPIKey(googleAPIKey)
        }
        return true
    }
}

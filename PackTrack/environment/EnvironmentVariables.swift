//
//  EnvironmentVariables.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-10.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import Foundation

enum EnvironmentVariables: String {
    case GOOGLE_API_KEY
    
    var value: String? {
        return ProcessInfo.processInfo.environment[rawValue]
    }
}

//
//  TrackingHistoryViewModel.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-25.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

class TrackingHistoryViewModel {
    var trackingHistory: [TrackingStatus]
    
    
    init(trackingHistory: [TrackingStatus]) {
        self.trackingHistory = trackingHistory
        print(trackingHistory.count)
    }
}


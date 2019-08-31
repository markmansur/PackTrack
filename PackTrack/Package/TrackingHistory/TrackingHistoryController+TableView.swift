//
//  TrackingHistoryController+UiTableView.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-08-25.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension TrackingHistoryController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? TrackingHistoryCell) else { return UITableViewCell() }
        cell.trackingStatus = viewModel?.trackingHistory[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.trackingHistory.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

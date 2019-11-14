//
//  AddPackageModal+ UIPickerViewDelegate.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-11-03.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension AddPackageModalViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return carriers[row].rawValue
    }
}

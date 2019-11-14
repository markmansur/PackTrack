//
//  AddPackageModal+UIPickerViewDataSource.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-11-03.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit


extension AddPackageModalViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return carriers.count
    }
    
    
}

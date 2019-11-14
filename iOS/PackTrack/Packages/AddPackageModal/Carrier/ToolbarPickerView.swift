//
//  ToolbarPickerView.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-11-04.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

protocol CarrierPickerViewDelegate {
    func didTapDone()
    func didTapCancel()
}

class CarrierPickerView: UIPickerView {
    var toolbar: UIToolbar?
    var carrierPickerViewDelegate: CarrierPickerViewDelegate?
    
    init() {
        super.init(frame: CGRect.null)
        setupToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupToolbar() {
        toolbar = UIToolbar()
        
        toolbar?.isTranslucent = true
        toolbar?.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolbar?.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        doneButton.tintColor = .darkBlue
        cancelButton.tintColor = .lightBlue
        
        toolbar?.setItems([cancelButton, spacer, doneButton], animated: false)
    }
    
    @objc private func handleDone() {
        carrierPickerViewDelegate?.didTapDone()
    }
    
    @objc private func handleCancel() {
        carrierPickerViewDelegate?.didTapCancel()
    }
    
}

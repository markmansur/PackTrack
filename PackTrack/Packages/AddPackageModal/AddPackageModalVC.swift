//
//  AddPackageModalVC.swift
//  PackTrack
//
//  Created by Mark Mansur on 2019-09-17.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

protocol AddPackageModalDelegate {
    func didAddPackage(name: String, trackingNumber: String)
}

class AddPackageModalViewController: UIViewController {
    var delegate: AddPackageModalDelegate?
    let carriers = Carrier.allCases
    
    private let nameLabel = UILabel(text: "Name", font: UIFont.boldSystemFont(ofSize: 17))
    private let trackingNumberLabel = UILabel(text: "Number", font: UIFont.boldSystemFont(ofSize: 17))
    private let carrierLabel = UILabel(text: "Carrier", font: UIFont.boldSystemFont(ofSize: 17))

    private let nameTextField = UITextField(placeholder: "Optional")
    private let trackingNumberTextField = UITextField(placeholder: "Required")
    private let carrierTextField = UITextField(placeholder: "Select Carrier")
    
    let modalBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let blueHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton(title: "Add", titleColor: .gray, target: self, action: #selector(handleAdd), touchEvent: .touchUpInside)
        button.backgroundColor = .customWhite
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lineSeparator
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private let carrierPickerView = CarrierPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeader()
        setupInputFields()
        setupCarrierPicker()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        view.addSubview(modalBackground)
        modalBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modalBackground.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        modalBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        modalBackground.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupHeader() {
        // MARK: header background
        modalBackground.addSubview(blueHeaderView)
        blueHeaderView.topAnchor.constraint(equalTo: modalBackground.topAnchor).isActive = true
        blueHeaderView.leftAnchor.constraint(equalTo: modalBackground.leftAnchor).isActive = true
        blueHeaderView.rightAnchor.constraint(equalTo: modalBackground.rightAnchor).isActive = true
        blueHeaderView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // MARK: cancel button
        let cancelButton = UIButton(title: "Cancel", titleColor: .customLightGray, target: self, action: #selector(handleCancel), touchEvent: .touchUpInside)
        blueHeaderView.addSubview(cancelButton)
        cancelButton.centerYAnchor.constraint(equalTo: blueHeaderView.centerYAnchor).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: blueHeaderView.leftAnchor, constant: 8).isActive = true
        
        // MARK: add button
        view.addSubview(addButton)
        addButton.centerYAnchor.constraint(equalTo: blueHeaderView.centerYAnchor).isActive = true
        addButton.rightAnchor.constraint(equalTo: blueHeaderView.rightAnchor, constant: -8).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupInputFields() {
        
        let numberStackView = UIStackView(arrangedSubviews: [trackingNumberLabel, trackingNumberTextField])
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        let carrierStackView = UIStackView(arrangedSubviews: [carrierLabel, carrierTextField])
        
        let mainStackView = UIStackView(arrangedSubviews: [numberStackView, nameStackView, carrierStackView])
        mainStackView.distribution = .equalSpacing
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSeparators(color: .lineSeparator)
        
        numberStackView.spacing  = 20
        nameStackView.spacing    = 37
        carrierStackView.spacing = 28
        mainStackView.spacing    = 12
        
        modalBackground.addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: blueHeaderView.bottomAnchor, constant: 10).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: modalBackground.centerXAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: modalBackground.widthAnchor, multiplier: 0.95).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    @objc private func handleCancel() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc private func handleAdd() {
        let nameText = nameTextField.text ?? ""
        let trackingNumberText = trackingNumberTextField.text ?? ""
        
        dismiss(animated: false) {
            self.delegate?.didAddPackage(name: nameText, trackingNumber: trackingNumberText)
        }
    }
    
    private func setupCarrierPicker() {
        carrierTextField.inputView = carrierPickerView
        carrierTextField.inputAccessoryView = carrierPickerView.toolbar
        
        carrierPickerView.dataSource = self
        carrierPickerView.delegate = self
        carrierPickerView.carrierPickerViewDelegate = self
    }
}

extension AddPackageModalViewController: CarrierPickerViewDelegate {
    func didTapDone() {
        let row = carrierPickerView.selectedRow(inComponent: 0)
        carrierTextField.text = carriers[row].rawValue
        carrierPickerView.selectRow(0, inComponent: 0, animated: false) // reset back to first option for when picker is re-openned
        carrierTextField.resignFirstResponder()
    }
    
    func didTapCancel() {
        carrierPickerView.selectRow(0, inComponent: 0, animated: false) // reset back to first option for when picker is re-openned
        carrierTextField.resignFirstResponder()
    }
}

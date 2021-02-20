//
//  SetUUIDViewController.swift
//  iBeaconTask
//
//  Created by Александр Шушков on 15.02.2021.
//  Copyright © 2021 Aleksandr Shushkov. All rights reserved.
//

import UIKit

class SetUUIDViewController: UIViewController {

    var uuidTextField: UITextField = {
        let uuidTextField = UITextField()
        uuidTextField.translatesAutoresizingMaskIntoConstraints = false
        uuidTextField.placeholder = "Enter UUID here..."
        uuidTextField.borderStyle = .roundedRect
        return uuidTextField
    }()
    
    var warningLabel: UILabel = {
        let warningLabel = UILabel()
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        warningLabel.isHidden = true
        warningLabel.text = "sample warning"
        warningLabel.textAlignment = .center
        warningLabel.textColor = .red
        warningLabel.numberOfLines = 0
        return warningLabel
    }()
    
    var continueButton: UIButton = {
        let continueButton = UIButton()
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.systemBlue, for: .normal)
        continueButton.addTarget(self, action: #selector(continuePressed), for:.touchUpInside)
        return continueButton
    }()
    
    @objc func continuePressed(sender: UIButton) {
        guard uuidTextField.hasText else {
            warningLabel.isHidden = false
            warningLabel.text = "UUID can't be empty"
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) { [weak self] in
                self?.uuidTextField.backgroundColor = .red
                self?.uuidTextField.backgroundColor = .clear
            }

            return
        }
        
        guard let uuidString = uuidTextField.text, let uuid = UUID(uuidString: uuidString) else {
            warningLabel.isHidden = false
            warningLabel.text = "Wrong UUID format, please enter correct UUID\nexample: E621E1F8-C36C-495A-93FC-0C247A3E6E5F"
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) { [weak self] in
                self?.uuidTextField.backgroundColor = .red
                self?.uuidTextField.backgroundColor = .clear
            }
            
            return
        }
        
        warningLabel.isHidden = true
        
        let beaconsContainer = BeaconsContainer(uuid: uuid)
        let VC = IBeaconsTableViewController(beaconsCoontainer: beaconsContainer)
        navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(uuidTextField)
        view.addSubview(warningLabel)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            uuidTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            uuidTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -32),
            uuidTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            warningLabel.topAnchor.constraint(equalTo: uuidTextField.bottomAnchor, constant: 16),
            warningLabel.leadingAnchor.constraint(equalTo: uuidTextField.leadingAnchor),
            warningLabel.trailingAnchor.constraint(equalTo: uuidTextField.trailingAnchor),
            
            continueButton.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 16),
            continueButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        navigationItem.title = "Set iBeacons UUID"
    }
}

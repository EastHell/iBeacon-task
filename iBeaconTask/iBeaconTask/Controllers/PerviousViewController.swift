//
//  PerviousViewController.swift
//  iBeaconTask
//
//  Created by Aleksandr on 14/01/2021.
//  Copyright © 2021 Aleksandr Shushkov. All rights reserved.
//

import UIKit

class PerviousViewController: UIViewController {

    let BLEButton: UIButton = {
        let bleButton = UIButton()
        bleButton.setTitle("BLE devices", for: .normal)
        bleButton.setTitleColor(.black, for: .normal)
        bleButton.translatesAutoresizingMaskIntoConstraints = false
        bleButton.addTarget(self, action: #selector(bleButtonPressed), for: .touchUpInside)
        return bleButton
    }()
    
    @objc func bleButtonPressed(sender: UIButton) {
        let bleVC = BLETableViewController(bleContainer: BLEContainer())
        navigationController?.pushViewController(bleVC, animated: true)
    }
    
    let beaconButton: UIButton = {
        let beaconButton = UIButton()
        beaconButton.setTitle("iBeacons", for: .normal)
        beaconButton.setTitleColor(.black, for: .normal)
        beaconButton.translatesAutoresizingMaskIntoConstraints = false
        beaconButton.addTarget(self, action: #selector(beaconButtonPressed), for: .touchUpInside)
        return beaconButton
    }()
    
    @objc func beaconButtonPressed(sender: UIButton) {
        let iBeaconsVC = IBeaconsTableViewController(beaconsCoontainer: BeaconsContainer())
        navigationController?.pushViewController(iBeaconsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "iBeacon task"
        
        view.backgroundColor = .white
        view.addSubview(BLEButton)
        view.addSubview(beaconButton)
        
        NSLayoutConstraint.activate([
            BLEButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 128),
            BLEButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            BLEButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            beaconButton.topAnchor.constraint(equalTo: BLEButton.bottomAnchor, constant: 8),
            beaconButton.leadingAnchor.constraint(equalTo: BLEButton.leadingAnchor),
            beaconButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -128),
            beaconButton.trailingAnchor.constraint(equalTo: BLEButton.trailingAnchor),
            beaconButton.heightAnchor.constraint(equalTo: BLEButton.heightAnchor)
            ])
    }
}

//
//  iBeaconViewController.swift
//  iBeaconTask
//
//  Created by Aleksandr on 17/01/2021.
//  Copyright © 2021 Aleksandr Shushkov. All rights reserved.
//

import UIKit
import CoreLocation

class iBeaconViewController: UIViewController, BeaconsContainerDelegate {
    
    var beaconsContainer: IBeaconsContainer
    var uuid: UUID
    var major: NSNumber
    var minor: NSNumber
    
    var majorLabel: UILabel = {
        var majorLabel = UILabel()
        majorLabel.translatesAutoresizingMaskIntoConstraints = false
        return majorLabel
    }()
    
    var minorLabel: UILabel = {
        var minorLabel = UILabel()
        minorLabel.translatesAutoresizingMaskIntoConstraints = false
        return minorLabel
    }()
    
    var rssiLabel: UILabel = {
        var rssiLabel = UILabel()
        rssiLabel.translatesAutoresizingMaskIntoConstraints = false
        return rssiLabel
    }()
    
    var accuracyLabel: UILabel = {
        var accuracyLabel = UILabel()
        accuracyLabel.translatesAutoresizingMaskIntoConstraints = false
        return accuracyLabel
    }()
    
    init(uuid: UUID, major: NSNumber, minor: NSNumber, beaconsContainer: IBeaconsContainer) {
        self.uuid = uuid
        self.major = major
        self.minor = minor
        self.beaconsContainer = beaconsContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(majorLabel)
        view.addSubview(minorLabel)
        view.addSubview(rssiLabel)
        view.addSubview(accuracyLabel)
        
        NSLayoutConstraint.activate([
            majorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            majorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            minorLabel.topAnchor.constraint(equalTo: majorLabel.topAnchor),
            minorLabel.leadingAnchor.constraint(equalTo: majorLabel.trailingAnchor, constant: 8),
            minorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            minorLabel.widthAnchor.constraint(equalTo: majorLabel.widthAnchor),
            
            rssiLabel.topAnchor.constraint(equalTo: majorLabel.bottomAnchor, constant: 8),
            rssiLabel.leadingAnchor.constraint(equalTo: majorLabel.leadingAnchor),
            rssiLabel.trailingAnchor.constraint(equalTo: minorLabel.trailingAnchor),
            
            accuracyLabel.topAnchor.constraint(equalTo: rssiLabel.bottomAnchor, constant: 8),
            accuracyLabel.leadingAnchor.constraint(equalTo: rssiLabel.leadingAnchor),
            accuracyLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            accuracyLabel.trailingAnchor.constraint(equalTo: rssiLabel.trailingAnchor)
            ])
        
        
        navigationItem.title = uuid.uuidString
        majorLabel.text = "major: \(major.intValue)"
        minorLabel.text = "minooor: \(minor.intValue)"
        if let beacon = beaconsContainer.beacons.first(where: { $0.proximityUUID == uuid && $0.major == major && $0.minor == minor }) {
            rssiLabel.text = "rssi: \(beacon.rssi)"
            accuracyLabel.text = "accuracy: \(beacon.accuracy)"
        } else {
            rssiLabel.text = "rssi: No data available"
            accuracyLabel.text = "accuracy: No data available"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        beaconsContainer.delegate = self
    }
    
    func update() {
        if let beacon = beaconsContainer.beacons.first(where: { $0.proximityUUID == uuid && $0.major == major && $0.minor == minor }) {
            rssiLabel.text = "rssi: \(beacon.rssi)"
            accuracyLabel.text = "accuracy: \(beacon.accuracy)"
        } else {
            rssiLabel.text = "rssi: No data available"
            accuracyLabel.text = "accuracy: No data available"
        }
    }
}

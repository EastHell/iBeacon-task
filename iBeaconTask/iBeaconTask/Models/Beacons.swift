//
//  Beacons.swift
//  iBeaconTask
//
//  Created by Aleksandr on 14/01/2021.
//  Copyright © 2021 Aleksandr Shushkov. All rights reserved.
//

import CoreLocation

protocol IBeaconsContainer {
    var delegate: BeaconsContainerDelegate? { get set }
    var beacons: [CLBeacon] { get }
}

protocol BeaconsContainerDelegate {
    func update()
}

class BeaconsContainer: NSObject, IBeaconsContainer, CLLocationManagerDelegate {
    
    var delegate: BeaconsContainerDelegate?
    
    private let locationManager = CLLocationManager()
    var beacons: [CLBeacon] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startScanning() {
        let uuid = UUID()
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 123, identifier: "iBeacon finder")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self), CLLocationManager.isRangingAvailable() {
                startScanning()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        self.beacons = beacons.sorted{ $0.accuracy < $1.accuracy }
        delegate?.update()
    }
}

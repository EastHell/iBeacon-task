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
    var beacons: [CLProximity: [CLBeacon]] { get }
    func startScanning()
    func stopScanning()
}

protocol BeaconsContainerDelegate {
    func update()
}

class BeaconsContainer: NSObject, IBeaconsContainer, CLLocationManagerDelegate {
    
    var delegate: BeaconsContainerDelegate?
    
    private static let locationManager = CLLocationManager()
    private let region: CLBeaconRegion
    
    var beacons = [CLProximity : [CLBeacon]]()
    
    init(uuid: UUID) {
        self.region = CLBeaconRegion(proximityUUID: uuid, identifier: uuid.uuidString)
        super.init()
        configure()
    }
    
    init(uuid: UUID, major: NSNumber) {
        self.region = CLBeaconRegion(proximityUUID: uuid, major: major.uint16Value, identifier: uuid.uuidString)
        super.init()
        configure()
    }
    
    init(uuid: UUID, major: NSNumber, minor: NSNumber) {
        self.region = CLBeaconRegion(proximityUUID: uuid, major: major.uint16Value, minor: minor.uint16Value, identifier: uuid.uuidString)
        super.init()
        configure()
    }
    
    func configure() {
        BeaconsContainer.locationManager.delegate = self
        BeaconsContainer.locationManager.requestWhenInUseAuthorization()
    }
    
    deinit {
        BeaconsContainer.locationManager.stopRangingBeacons(in: region)
        BeaconsContainer.locationManager.stopMonitoring(for: region)
    }
    
    func startScanning() {
        BeaconsContainer.locationManager.startMonitoring(for: region)
    }
    
    func stopScanning() {
        beacons.removeAll()
        BeaconsContainer.locationManager.stopRangingBeacons(in: region)
        BeaconsContainer.locationManager.stopMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        self.beacons.removeAll()
        
        for range in [CLProximity.unknown, .immediate, .near, .far] {
            let proximityBeacons = beacons.filter { $0.proximity == range }
            if !proximityBeacons.isEmpty {
                self.beacons[range] = proximityBeacons
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        let beaconRegion = region as! CLBeaconRegion
        if state == .inside {
            manager.startRangingBeacons(in: beaconRegion)
        } else {
            manager.stopRangingBeacons(in: beaconRegion)
        }
    }
}

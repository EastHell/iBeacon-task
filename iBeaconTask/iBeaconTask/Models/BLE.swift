//
//  BLE.swift
//  iBeaconTask
//
//  Created by Aleksandr on 18/01/2021.
//  Copyright © 2021 Aleksandr Shushkov. All rights reserved.
//

import Foundation
import CoreBluetooth

struct BLE {
    var peripheral: CBPeripheral
    var rssi: NSNumber
}

protocol IBLEContainer {
    var delegate: BLEContainerDelegate? { get set }
    var ble: [BLE] { get }
    func reload()
}

protocol BLEContainerDelegate {
    func update()
}

class BLEContainer: NSObject, IBLEContainer, CBCentralManagerDelegate {
    
    var delegate: BLEContainerDelegate?
    lazy var centralManager: CBCentralManager = {
        var cm = CBCentralManager(delegate: self, queue: nil)
        return cm
    }()
    
    var ble: [BLE] = []
    
    deinit {
        centralManager.stopScan()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        default:
            print("Bluetooth not powered on")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        ble.append(BLE(peripheral: peripheral, rssi: RSSI))
        delegate?.update()
    }
    
    func reload() {
        centralManager.stopScan()
        ble.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
}

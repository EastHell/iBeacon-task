//
//  IBeaconsTableViewController.swift
//  iBeaconTask
//
//  Created by Aleksandr on 14/01/2021.
//  Copyright © 2021 Aleksandr Shushkov. All rights reserved.
//

import UIKit

class IBeaconsTableViewController: UITableViewController, BeaconsContainerDelegate {

    var beaconsContainer: IBeaconsContainer
    
    init(beaconsCoontainer: IBeaconsContainer) {
        self.beaconsContainer = beaconsCoontainer
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "iBeacons"
        tableView.register(iBeaconTableViewCell.self, forCellReuseIdentifier: "iBeaconIdentifier")
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        beaconsContainer.delegate = self
        beaconsContainer.startScanning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        beaconsContainer.stopScanning()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        let sectionsKeys = Array(beaconsContainer.beacons.keys)
        
        let sectionKey = sectionsKeys[section]
        
        switch sectionKey {
        case .immediate:
            title = "Immediate"
        case .near:
            title = "Near"
        case .far:
            title = "Far"
        default:
            title = "Unknown"
        }
        
        return title
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return beaconsContainer.beacons.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(beaconsContainer.beacons.values)[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iBeaconIdentifier",
                                                 for: indexPath) as! iBeaconTableViewCell
        
        let sectionKey = Array(beaconsContainer.beacons.keys)[indexPath.section]
        let beacon = beaconsContainer.beacons[sectionKey]![indexPath.row]
        
        cell.uuidLabel.text = "UUID: \(beacon.proximityUUID.uuidString)"
        cell.majorLabel.text = "major: \(beacon.major.intValue)"
        cell.minorLabel.text = "minor: \(beacon.minor.intValue)"
        cell.rssiLabel.text = "rssi: \(beacon.rssi)"
        cell.accuracyLabel.text = "accuracy: \(beacon.accuracy)"
        
        return cell
    }
    
    func update() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionKey = Array(beaconsContainer.beacons.keys)[indexPath.section]
        let beacon = beaconsContainer.beacons[sectionKey]![indexPath.row]
        let beaconContainer = BeaconsContainer(uuid: beacon.proximityUUID, major: beacon.major, minor: beacon.minor)
        let vc = iBeaconViewController(beaconsContainer: beaconContainer)
        navigationController?.pushViewController(vc, animated: true)
    }
}

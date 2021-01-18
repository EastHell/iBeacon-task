//
//  BLETableViewController.swift
//  iBeaconTask
//
//  Created by Aleksandr on 18/01/2021.
//  Copyright © 2021 Aleksandr Shushkov. All rights reserved.
//

import UIKit

class BLETableViewController: UITableViewController, BLEContainerDelegate {

    var bleContainer: IBLEContainer
    
    init(bleContainer: IBLEContainer) {
        self.bleContainer = bleContainer
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "BLE"
        tableView.register(BLETableViewCell.self, forCellReuseIdentifier: "BLECellIdentifier")
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        bleContainer.delegate = self
        
        refresh()
    }
    
    @objc func refresh() {
        bleContainer.reload()
        refreshControl?.endRefreshing()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bleContainer.ble.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BLECellIdentifier", for: indexPath) as! BLETableViewCell

        let ble = bleContainer.ble.sorted(by: { $0.rssi.intValue > $1.rssi.intValue })[indexPath.row]
        
        cell.nameLabel.text = ble.peripheral.name
        cell.rssiLabel.text = "rssi: \(ble.rssi)"

        return cell
    }
    
    func update() {
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.endUpdates()
    }
}

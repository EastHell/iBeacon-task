//
//  ViewController.swift
//  iBeaconTask
//
//  Created by Aleksandr on 14/01/2021.
//  Copyright © 2021 Aleksandr Shushkov. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}


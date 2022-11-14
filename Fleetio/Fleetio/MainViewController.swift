//
//  ViewController.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import UIKit

class MainViewController: UIViewController {
    
    let vehicleVM = VehicleViewModel()
    var vehicles = [Vehicle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVMData()
        configureViews()
        
        
        
    }
    
    func configureVMData() {
        vehicleVM.getVehicles { newVehicles in
            self.vehicles = newVehicles
        }
    }
    
    func configureViews() {
        
    }

}

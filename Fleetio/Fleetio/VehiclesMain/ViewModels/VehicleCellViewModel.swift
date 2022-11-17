//
//  VehicleCellViewModel.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-16.
//

import Foundation

class VehicleCellViewModel {
    let name: String?
    let model: String?
    let image: URL?
    let make: String?
    
    init(name:  String?, model: String?, image: URL?, make: String?) {
        self.name = name
        self.model = model
        self.image = image
        self.make = make
    }
}

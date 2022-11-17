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
    let image: String?
    let make: String?
    
    init(name:  String?, model: String?, image: String?, make: String?) {
        self.name = name
        self.model = model
        self.image = image
        self.make = make
        
        convertToImage(urlString: image)
    }
    
    func convertToImage(urlString: String?) {
        
    }
}

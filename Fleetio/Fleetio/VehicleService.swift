//
//  VehicleService.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import Foundation


class VehicleService {
    
    func getVehicles() {
        let apiElements = ApiElements()
        
        let request = apiElements.getMutableRequest(section: "vehicles")
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = apiElements.headers
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard let vehicleData = data else {
                return
            }
            
            var vehicleResponse: [VehicleAssets]?
            
            do {
                vehicleResponse = try JSONDecoder().decode([VehicleAssets].self, from: vehicleData)
            } catch {
                print(String(describing: error))
            }

            guard let finalvehicleResponse = vehicleResponse else { return }

            print(finalvehicleResponse[9].make)
            
        }).resume()
    }
    
}

//
//  VehicleService.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import Foundation


class VehicleViewModel {
    
    
    func getVehicles(completion: @escaping ([Vehicle]) ->()) {
        let apiElements = ApiElements()
        
        let request = apiElements.getMutableRequest(section: "vehicles")
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = apiElements.headers
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard let vehicleData = data else {
                return
            }
            
            var vehicleResponse: [Vehicle]?
            
            do {
                vehicleResponse = try JSONDecoder().decode([Vehicle].self, from: vehicleData)
                guard let finalvehicleResponse = vehicleResponse else { return }
                
                completion(finalvehicleResponse)
            } catch {
                print(String(describing: error))
            }
            
            
            
        }).resume()
        
    }
    
}

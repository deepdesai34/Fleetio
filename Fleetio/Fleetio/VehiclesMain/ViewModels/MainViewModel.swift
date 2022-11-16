//
//  VehicleService.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import Foundation


class MainViewModel {
    

    
    private func getHeaderDetails(completion: @escaping (Int, Int) -> ()) {
        let apiElements = ApiManager()
        
        let request = apiElements.getMutableRequest(section: "vehicles")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
            let httpResponse = response as? HTTPURLResponse

            guard let paginationLimit = Int(httpResponse?.value(forHTTPHeaderField: "X-Pagination-Limit") ?? "1"), let paginationTotal = Int(httpResponse?.value(forHTTPHeaderField: "X-Pagination-Total-Pages") ?? "1") else { return }
           
            completion(paginationLimit, paginationTotal)
        }).resume()
    }
    
    func getVehicles(completion: @escaping ([Vehicle]) ->()) {
        
        getHeaderDetails { limit, total in
            
            let apiElements = ApiManager()
            
            let request = apiElements.getMutableRequest(section: "vehicles?page=6")
            request.httpMethod = "GET"
            
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
}

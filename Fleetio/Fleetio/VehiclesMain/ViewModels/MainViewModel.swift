//
//  VehicleService.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import Foundation


class MainViewModel {
    
    var isPaginating: Bool = false
    
    
    
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[Vehicle], Error>) -> Void) {
        var originalData = [Vehicle]()
        var newData = [Vehicle]()
        
        if pagination {
            isPaginating = true
        }
        
        getHeaderDetails(completion: { currentPage, totalPages in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3:2), execute: { [self] in
                
                getVehicles(i: currentPage, completion: { [self] oldVehicles in
                    originalData = oldVehicles
                    
                    if (currentPage + 1) <= totalPages {
                        self.getVehicles(i: currentPage + 1, completion: { newVehicles in
                            newData = newVehicles
                            completion(.success(pagination ? newData : originalData))
                        })
                       
                    }
                    completion(.success(pagination ? newData : originalData))
                    
                    if pagination {
                        self.isPaginating = false
                    }
                })
            })
            
        })
        
        
    }
    
    
    private func getHeaderDetails(completion: @escaping (Int, Int) -> ()) {
        let apiElements = ApiManager()
        
        let request = apiElements.getMutableRequest(section: "vehicles")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            let httpResponse = response as? HTTPURLResponse
            
            guard let currentPage = Int(httpResponse?.value(forHTTPHeaderField: "X-Pagination-Current-Page") ?? "1"), let paginationTotal = Int(httpResponse?.value(forHTTPHeaderField: "X-Pagination-Total-Pages") ?? "1") else { return }
            
            completion(currentPage, paginationTotal)
        }).resume()
    }
    
    
    
    private func getVehicles(i: Int, completion: @escaping ([Vehicle]) ->()) {
        let apiElements = ApiManager()
        let request = apiElements.getMutableRequest(section: "vehicles?page=\(i)")
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

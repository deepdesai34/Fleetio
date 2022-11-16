//
//  VehicleService.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import Foundation


class MainViewModel {
    
    var isPaginating: Bool = false
    var currentPage: Int = 0
    var totalPages: Int = 0
    var originalData = [Vehicle]()
    var newData = [Vehicle]()
    
    
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[Vehicle], Error>) -> Void) {
        if pagination {
            isPaginating = true
        }
        
        if self.isPaginating && self.currentPage <= totalPages {
            self.currentPage += 1
        }
        DispatchQueue.global().asyncAfter(deadline: .now(), execute: { [self] in
            
            getVehicles(i: self.currentPage, completion: { oldVehicles in
                self.originalData = oldVehicles
                
                if ((self.currentPage) <= self.totalPages) && self.isPaginating {
                    self.getVehicles(i: self.currentPage, completion: { newVehicles in
                        self.newData = newVehicles
                        completion(.success(pagination ? self.newData : self.originalData))
                    })
                    
                }
                completion(.success(pagination ? self.newData : self.originalData))
                
                if pagination {
                    self.isPaginating = false
                }
            })
        })
        
        
        
        
    }
    
    
    func getHeaderDetails(completion: @escaping (Int, Int) -> ()) {
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
    
    func resetData() {
        originalData.removeAll()
        newData.removeAll()
    }
    
}

//
//  VehicleService.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import Foundation


class MainViewModel {
    
    // Public variables
    var isPaginating: Bool = false
    var currentPage: Int = 0
    var totalPages: Int = 0
    var vehicles = [Vehicle]()
    var searchedVehicles = [Vehicle]()
    var searching: Bool = false
    
    // private variables
    private var isThere: Bool?
    private var originalData = [Vehicle]()
    private var newData = [Vehicle]()
    private var apiManager: ApiManager?
    
    
    // Request Functions
    
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[Vehicle], Error>) -> Void) {
        // Checks if we want to add new data AKA paginate new data or pull first data
        if pagination {
            isPaginating = true
        }

        if self.isPaginating && self.currentPage <= totalPages {
            self.currentPage += 1
        }
        
        // pulls first data or new paginated data
        DispatchQueue.global().asyncAfter(deadline: .now(), execute: { [self] in
            
            getVehicles(i: self.currentPage, completion: { oldVehicles in
                self.originalData = oldVehicles
                
                if ((self.currentPage) <= self.totalPages) && self.isPaginating {
                    self.getVehicles(i: self.currentPage, completion: { newVehicles in
                        self.newData = newVehicles
                    })
                }
                
                completion(.success(pagination ? self.newData : self.originalData))
                
                if pagination {
                    self.isPaginating = false
                }
            })
        })
    }
    
    // Pulls details from header for pagination such as current and total pages from vehicles api
    func getHeaderDetails(completion: @escaping (Int, Int) -> ()) {
        apiManager = ApiManager()
        
        guard let apiMan = apiManager else { return }
        let request = apiMan.getMutableRequest(section: "vehicles")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            let httpResponse = response as? HTTPURLResponse
            
            guard let currentPage = Int(httpResponse?.value(forHTTPHeaderField: "X-Pagination-Current-Page") ?? "1"), let paginationTotal = Int(httpResponse?.value(forHTTPHeaderField: "X-Pagination-Total-Pages") ?? "1") else { return }
            
            completion(currentPage, paginationTotal)
        }).resume()
    }
    
    
    // Object Functions
    
    // resets arrays
    func resetData() {
        originalData.removeAll()
        newData.removeAll()
    }
    
    // checks if user inputted text matches any of the vehicle names
    func isSearching(searchText: String) -> Bool {
        if !(searching && searchText != "") {
            return false
        }
        
        return true
    }
    
    // filters and creates new array of vehicles based on users search
    func filterSearch(text: String) {
        searchedVehicles = vehicles.filter({
            
            if let name = $0.name {
                isThere = name.contains(text)
            }
            return isThere ?? false
        })
    }
    
    // Private Functions
    
    // Makes API Request, Decodes JSON into Array of Vehicles
    private func getVehicles(i: Int, completion: @escaping ([Vehicle]) ->()) {
        apiManager = ApiManager()
        
        guard let apiMan = apiManager else { return }
        
        // Gets vehicle pagination in Ascending order by vehicle name
        let request = apiMan.getMutableRequest(section: "vehicles?page=\(i)?q[s]=name+asc")
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

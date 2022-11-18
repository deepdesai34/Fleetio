//
//  VehicleDetailViewModel.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-17.
//

import Foundation
import CoreLocation
import MapKit

class VehicleDetailViewModel {
    
    var coordinate: CLLocationCoordinate2D?
    var region: MKCoordinateRegion?
    var longitudeDouble: Double?
    var latitudeDouble: Double?
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    init(coordinate: CLLocationCoordinate2D? = nil, region: MKCoordinateRegion? = nil, longitudeDouble: Double?, latitudeDouble: Double?, latitude: CLLocationDegrees? = nil, longitude: CLLocationDegrees? = nil) {
        self.coordinate = coordinate
        self.region = region
        self.longitudeDouble = longitudeDouble
        self.latitudeDouble = latitudeDouble
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func render(latitude: Double, longitude: Double) {
        
        self.latitude = CLLocationDegrees(floatLiteral: latitude)
        self.longitude = CLLocationDegrees(floatLiteral: longitude)
        
        if let lat = self.latitude, let long = self.longitude {
            
            coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        if let coord = self.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            region = MKCoordinateRegion(center: coord, span: span)
            
        }
        
    }
    
    
    
}


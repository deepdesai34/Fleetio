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
    
    // Vehicle Info
    
    // Meter Values
    var currentMeter: Double?
    var secondaryMeter: Double?
    
    //Vehicle Status
    var vehicleStatusID: Double?
    var vehicleStatusName: String?
    var vehicleStatusColor: String?
    
    // Driver Info
    var driverFullName: String?
    
    // Vin
    var vin: String?
    
    //License Plate
    var licensePlate: String?
    
    // Map Info
    var coordinate: CLLocationCoordinate2D?
    var region: MKCoordinateRegion?
    var longitudeDouble: Double?
    var latitudeDouble: Double?
    
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    private var vehicle: Vehicle?
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        
        //Map
        latitudeDouble = vehicle.currentLocationEntry?.geolocation?.latitude
        longitudeDouble = vehicle.currentLocationEntry?.geolocation?.longitude
        
        // vehicle info
        
        //meter values
        currentMeter = vehicle.currentMeterValue
        secondaryMeter = vehicle.secondaryMeterValue
        
        // vehicle status
        vehicleStatusID = vehicle.vehicleStatusID
        vehicleStatusName = vehicle.vehicleStatusName
        vehicleStatusColor = vehicle.vehicleStatusColor
        
        //Driver info
        driverFullName = vehicle.driver?.fullName
        
        //vin
        vin = vehicle.vin
        
        //license
        licensePlate = vehicle.licensePlate
        
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


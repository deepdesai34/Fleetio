//
//  VehicleDetailViewController.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-17.
//

import UIKit
import MapKit
import CoreLocation

class VehicleDetailViewController: UIViewController {
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 5
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        
        render(latitude: 29.794931, longitude: -95.032926)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 15),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        ])
    }
    
    func render(latitude: Double, longitude: Double) {
        
        let lat = CLLocationDegrees(floatLiteral: latitude)
        let long = CLLocationDegrees(floatLiteral: longitude)
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        
    }
    
}




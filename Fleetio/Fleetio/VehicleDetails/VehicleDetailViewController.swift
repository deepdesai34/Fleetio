//
//  VehicleDetailViewController.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-17.
//

import UIKit
import MapKit
import CoreLocation

//meter/secondary meter values, vehicle status, driver info, VIN, license plate,

class VehicleDetailViewController: UIViewController {
    
    var detailVM: VehicleDetailViewModel?
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.separatorStyle = .singleLine
        table.separatorColor = .fleetioGreen
        table.sectionIndexColor = .white
        table.tableFooterView?.isHidden = true
        
        
        return table
    }()
    
    
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
        view.addSubview(tableView)
        view.addSubview(mapView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        
        
    }
    
    func setupMap() {
        
        if let long = detailVM?.longitudeDouble, let lat = detailVM?.latitudeDouble {
            detailVM?.render(latitude: lat, longitude: long)
        }
        
        
        if let region = detailVM?.region, let coordinates = detailVM?.coordinate {
            mapView.setRegion(region, animated: true)
            
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            mapView.addAnnotation(pin)
        }
        
        
        //let region = detailVM?.region,
        //let coordinates = detailVM?.coordinate,
    }
    
    func bindVM(viewModel: VehicleDetailViewModel) {
        detailVM = viewModel
        setupMap()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 15),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor, constant: -15),
        ])
    }
}


extension VehicleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = "name"
        configuration.secondaryText = "deep"
        configuration.image = UIImage(named: "InfoIcon")
        
        
        cell.contentConfiguration = configuration
        
        return cell
    }
}

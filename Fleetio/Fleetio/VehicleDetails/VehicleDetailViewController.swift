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
   
    // Vehicle Detail ViewModel
    var detailVM: VehicleDetailViewModel?
    
    // Views
    
    let tableView: UITableView = {
        let table = UITableView(frame: CGRect(), style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.separatorStyle = .singleLine
        table.separatorColor = .fleetioGreen
        table.tableFooterView?.isHidden = true
        
        return table
    }()
    
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 5
        
        return mapView
    }()
    
    let emptyMapImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "mappin.slash.circle")
        imageView.tintColor = .fleetioGreen
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
    }
    
    // Table Configuration
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(emptyMapImage)
        view.addSubview(mapView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
    }
    
    // Map Configuration
    func setupMap() {
        
        if let long = detailVM?.longitudeDouble, let lat = detailVM?.latitudeDouble {
            detailVM?.render(latitude: lat, longitude: long)
        }
        
        if let region = detailVM?.region, let coordinates = detailVM?.coordinate {
            mapView.setRegion(region, animated: true)
            
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            mapView.addAnnotation(pin)
        } else {
            mapView.isHidden = true
        }
    }
    
    // ViewModel Configuration
    func bindVM(viewModel: VehicleDetailViewModel) {
        detailVM = viewModel
        setupMap()
    }
    
    // Constraint Configuration
    func configureConstraints() {
        
        NSLayoutConstraint.activate([
            emptyMapImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 25),
            emptyMapImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            emptyMapImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            emptyMapImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
        ])
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 15),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor, constant: -15),
        ])
    }
}


extension VehicleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 1
        }
    }
    
    // Titles
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Meter Info"
        case 1:
            return "Vehicle Status"
        case 2:
            return "Driver Info"
        case 3:
            return "vin"
        case 4:
            return "licensePlate"
        default:
            return ""
        }
    }
    
    // Data binding to views based on ViewModel
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        
        switch indexPath.section {
            // Meter
        case 0:
            if indexPath.row == 0 {
                configuration.text = "Current Meter"
                configuration.secondaryText = String(format: "%.2f", detailVM?.currentMeter ?? "N/A")
            } else {
                configuration.text = "Secondary Meter"
                configuration.secondaryText = String(format: "%.2f", detailVM?.secondaryMeter ?? "N/A")
            }
            // Vehicle
        case 1:
            
            if indexPath.row == 0 {
                configuration.text = "Vehicle ID"
                configuration.secondaryText = String(format: "%.0f", detailVM?.vehicleStatusID ?? "N/A")
            } else if indexPath.row == 1 {
                configuration.text = "Vehicle Name"
                configuration.secondaryText = detailVM?.vehicleStatusName ?? "N/A"
            } else {
                configuration.text = "Vehicle Color"
                configuration.secondaryText = detailVM?.vehicleStatusColor ?? "N/A"
            }
            
        case 2:
            configuration.text = "Full Name"
            configuration.secondaryText = detailVM?.driverFullName ?? "N/A"
        case 3:
            configuration.text = "Vin"
            configuration.secondaryText = detailVM?.vin ?? "N/A"
        case 4:
            configuration.text = "Plate Number"
            configuration.secondaryText = detailVM?.licensePlate ?? "N/A"
        default:
            return UITableViewCell()
        }
        
        configuration.image = UIImage(named: "InfoIcon")
        
        cell.contentConfiguration = configuration
        cell.selectionStyle = .none
        
        return cell
    }
}

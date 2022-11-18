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
    
    var detailVM: VehicleDetailViewModel?
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.separatorStyle = .singleLine
        table.separatorColor = .fleetioGreen
        table.tableFooterView?.isHidden = true
        table.layer.borderColor = UIColor.fleetioGreen.cgColor
        table.layer.borderWidth = 0.5
        
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
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(emptyMapImage)
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
        } else {
            mapView.isHidden = true
        }
    }
    
    func bindVM(viewModel: VehicleDetailViewModel) {
        detailVM = viewModel
        setupMap()
    }
    
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
        cell.selectionStyle = .none
        
        return cell
    }
}

//
//  ViewController.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import UIKit

class VehicleViewController: UIViewController {
    
    //VMs
    let mainVM = MainViewModel()
    
    //Objects
    var vehicles = [Vehicle]()
    var searchedVehicle = [Vehicle]()
    
    //Variables
    var searching: Bool = false
    
    //UI Variables
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedTitleFont(ofSize: 30, weight: .bold)
        label.text = "Vehicles"
        
        return label
    }()
    
    let vehicleSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search By Name"
        
        return searchBar
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.separatorStyle = .singleLine
        table.sectionIndexColor = .black
        table.tableFooterView?.isHidden = true
        
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVMData()
        configureViews()
        configureConstraints()
        
    }
    
    func configureViews() {
        //MainView
        view.backgroundColor = .white
        
        //TitleLabel
        view.addSubview(titleLabel)
        
        //SearchBar
        view.addSubview(vehicleSearchBar)
        vehicleSearchBar.delegate = self
    
        // TableView
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func configureConstraints() {
        
        //TitleLabel
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            // titleLabel.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor)
        ])
        
        //SearchBar
        NSLayoutConstraint.activate([
            vehicleSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vehicleSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            vehicleSearchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        ])
        
        //TableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: vehicleSearchBar.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: vehicleSearchBar.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: vehicleSearchBar.safeAreaLayoutGuide.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    func configureVMData() {
        // Binding data for vehicles from viewModel
        mainVM.getVehicles { newVehicles in
            self.vehicles = newVehicles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// TableView Protocols
extension VehicleViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if !(searching && vehicleSearchBar.text != "") {
            return vehicles.count
        } else {
            return searchedVehicle.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        if !(searching && vehicleSearchBar.text != "") {
            configuration.text = vehicles[indexPath.row].name
        } else {
            configuration.text = searchedVehicle[indexPath.row].name
        }
        
        cell.contentConfiguration = configuration
        
        
        return cell
    }
}

// Search Functionality
extension VehicleViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchedVehicle = vehicles.filter({ $0.name?.contains(searchText) })
//        searching = true
//        tableView.reloadData()
//    }
}



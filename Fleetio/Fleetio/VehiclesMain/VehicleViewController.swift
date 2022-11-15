//
//  ViewController.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import UIKit

class VehicleViewController: UIViewController {
    
    
    let mainVM = MainViewModel()
    var vehicles = [Vehicle]()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedTitleFont(ofSize: 30, weight: .bold)
        label.text = "Vehicles"
        
        return label
    }()
    
    let vehicleSearchController: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = 10
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
        view.addSubview(vehicleSearchController)
        
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
            vehicleSearchController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vehicleSearchController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            vehicleSearchController.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        ])
        
        //TableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: vehicleSearchController.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: vehicleSearchController.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: vehicleSearchController.safeAreaLayoutGuide.bottomAnchor),
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        view.layer.cornerRadius = 5
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Courier-BoldOblique", size: 25)
//        label.textColor = .white
//
//
//        label.text = vehicles[section].name
//        view.addSubview(label)
//
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        ])
        
        let vehicleView = VehicleHeader()
        
        let vehicleVM = VehicleHeaderViewModel(vehicleName:vehicles[section].name)
        vehicleView.setup(viewModel: vehicleVM)

        return vehicleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vehicles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        
        
        
        switch indexPath.row {
        case 0:
            
            configuration.text = "Vehicle Make"
            configuration.secondaryText = vehicles[indexPath.section].make
            
        case 1:
            configuration.text = "Vehcile Name"
            configuration.secondaryText = vehicles[indexPath.section].name
            
        case 2:
            
            configuration.text = vehicles[indexPath.section].make
            //let vehicleImageView = UIImageView()
          //  guard let url = URL(string: vehicles[indexPath.section].defaultImageURL) else { return "" }
            
           // configuration.image?.load(url: url)
            
        case 3:
            configuration.text = vehicles[indexPath.section].make
            
        default:
            configuration.text = ""
            
        }
        
        cell.contentConfiguration = configuration
        
        
        return cell
    }
}




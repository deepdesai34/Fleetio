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
    
    //UI Variables
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedTitleFont(ofSize: 30, weight: .bold)
        label.textColor = .fleetioGreen
        label.text = "Vehicles"
        
        return label
    }()
    
    let vehicleSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search By Name"
        searchBar.backgroundColor = .fleetioGreen
        
        return searchBar
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.separatorStyle = .singleLine
        table.separatorColor = .black
        table.sectionIndexColor = .white
        table.tableFooterView?.isHidden = true
        
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl?.beginRefreshing()
        bindHeaderDetails()
        configureViews()
        configureConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureVMFetch(pagination: false)
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
        tableView.register(VehicleTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .fleetioGreen
        tableView.refreshControl?.addTarget(self, action: #selector(pullDownToRefresh), for: .valueChanged)
    }
    
    func configureConstraints() {
        
        //TitleLabel
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
        
        //SearchBar
        NSLayoutConstraint.activate([
            vehicleSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vehicleSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            vehicleSearchBar.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        ])
        
        //TableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: vehicleSearchBar.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: vehicleSearchBar.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: vehicleSearchBar.safeAreaLayoutGuide.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    func configureVMFetch(pagination: Bool, reloadData: Bool = true) {
        // Binding data for vehicles from viewModel
        mainVM.fetchData(pagination: pagination, completion: { result in
            switch result {
            case .success(let data):
                self.mainVM.vehicles.append(contentsOf: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                print("Failed to fetch data")
            }
        })
    }
    
    func bindHeaderDetails(isRefresh: Bool = false) {
        
        if isRefresh {
            self.mainVM.currentPage = 0
        }
        
        mainVM.getHeaderDetails(completion: { currentPage, totalPages in
            self.mainVM.currentPage = currentPage
            self.mainVM.totalPages = totalPages
        })
    }
    
    @objc func pullDownToRefresh() {
        tableView.tableFooterView = nil
        
        mainVM.vehicles.removeAll()
        mainVM.searchedVehicles.removeAll()
        tableView.setNeedsDisplay()
        mainVM.resetData()
        bindHeaderDetails(isRefresh: true)
        configureVMFetch(pagination: false, reloadData: false)
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
        
    }
}

// TableView Protocols
extension VehicleViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !mainVM.isSearching(searchText: vehicleSearchBar.text ?? "") {
            return mainVM.vehicles.count
        } else {
            return mainVM.searchedVehicles.count
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: VehicleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VehicleTableViewCell else { return UITableViewCell() }
       
        cell.selectionStyle = .none
        
        if !mainVM.isSearching(searchText: vehicleSearchBar.text ?? "") {
            
            let vehicleName = mainVM.vehicles[indexPath.row].name
            let vehicleMake = mainVM.vehicles[indexPath.row].make
            let vehicleModel = mainVM.vehicles[indexPath.row].model
            let vehicleImage = mainVM.vehicles[indexPath.row].defaultImageURL
            
            let cellVM = VehicleCellViewModel(name: vehicleName, model: vehicleModel, image: vehicleImage, make: vehicleMake)
            cell.setup(cellViewModel: cellVM)
        } else {
            
            let searchedName = mainVM.searchedVehicles[indexPath.row].name
            let searchedMake = mainVM.searchedVehicles[indexPath.row].make
            let searchedModel = mainVM.searchedVehicles[indexPath.row].model
            let vehicleImage = mainVM.searchedVehicles[indexPath.row].defaultImageURL
            
            let cellVM = VehicleCellViewModel(name: searchedName, model: searchedModel, image: vehicleImage, make: searchedMake)
            cell.setup(cellViewModel: cellVM)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row + 1 == mainVM.vehicles.count {
            guard !mainVM.isPaginating else {
                return
            }
            
            if self.mainVM.currentPage < self.mainVM.totalPages {
                self.tableView.tableFooterView = createFooterSpinner()
                configureVMFetch(pagination: true)
            } else {
                self.tableView.tableFooterView = nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = VehicleDetailViewController()
        let navController = UINavigationController(rootViewController: detailVC)
        
        navController.title = "yo"
        
        if !mainVM.isSearching(searchText: vehicleSearchBar.text ?? "") {
            
            let vehicleName = mainVM.vehicles[indexPath.row].name
            let vehicleLongitude = mainVM.vehicles[indexPath.row].currentLocationEntry?.geolocation?.longitude
            let vehicleLatitude = mainVM.vehicles[indexPath.row].currentLocationEntry?.geolocation?.latitude
            
            self.present(navController, animated: true)
            
        } else {
            
            let searchedName = mainVM.searchedVehicles[indexPath.row].name
            let searchedLongitude = mainVM.searchedVehicles[indexPath.row].currentLocationEntry?.geolocation?.longitude
            let searchedLatitude = mainVM.searchedVehicles[indexPath.row].currentLocationEntry?.geolocation?.latitude
            
            self.present(navController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
    // Footer spinner
    private func createFooterSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        spinner.color = .fleetioGreen
        
        return footerView
    }
    
}

// Search Functionality
extension VehicleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        mainVM.filterSearch(text: searchText)
        
        mainVM.searching = true
        tableView.reloadData()
    }
}



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
        table.separatorColor = .fleetioGreen
        table.sectionIndexColor = .white
        table.tableFooterView?.isHidden = true
        
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindPaginationDetails()
        configureViews()
        configureConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureVMFetch(pagination: false)
    }
    
    // View Configuration
    func configureViews() {
        // empty state for initial data load
        tableView.setEmptyMessage("Loading ...")
        
        //MainView
        view.backgroundColor = .white
        
        //TitleLabel
        view.addSubview(titleLabel)
        
        //SearchBar
        view.addSubview(vehicleSearchBar)
        vehicleSearchBar.delegate = self
        
        // TableView
        view.addSubview(tableView)
        tableView.register(VehicleTableViewCell.self, forCellReuseIdentifier: "MainCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // Refresh controller for table
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
    
    // Binding data for vehicles from viewModel to view
    func configureVMFetch(pagination: Bool, reloadData: Bool = true) {
        mainVM.fetchData(pagination: pagination, completion: { result in
            switch result {
            case .success(let data):
                self.mainVM.vehicles.append(contentsOf: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.restore()
                }
            case .failure(_):
                self.tableView.setEmptyMessage("Error Could Not Load")
                print("Failed to fetch data")
            }
        })
    }
    
    //Binding header details for pagination
    func bindPaginationDetails(isRefresh: Bool = false) {
        if isRefresh {
            self.mainVM.currentPage = 0
        }
        
        mainVM.getHeaderDetails(completion: { currentPage, totalPages in
            self.mainVM.currentPage = currentPage
            self.mainVM.totalPages = totalPages
        })
    }
    
    // refresh for when pulling down ( reloading table )
    @objc func pullDownToRefresh() {
        tableView.tableFooterView = nil
        tableView.restore()
        mainVM.vehicles.removeAll()
        mainVM.searchedVehicles.removeAll()
        tableView.setNeedsDisplay()
        mainVM.resetData()
        bindPaginationDetails(isRefresh: true)
        configureVMFetch(pagination: false, reloadData: true)
        tableView.reloadData()
        
    }
}

// TableView Protocols
extension VehicleViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return vehicle array count without search
        if !mainVM.isSearching(searchText: vehicleSearchBar.text ?? "") {
            return mainVM.vehicles.count
        } else {
            
            // return vehicle array count with search
            if mainVM.searchedVehicles.count == 0 {
                tableView.setEmptyMessage("No Search Results Found!")
            } else {
                tableView.restore()
            }
            return mainVM.searchedVehicles.count
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: VehicleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? VehicleTableViewCell else { return UITableViewCell() }
       
        cell.selectionStyle = .none

        // configure cell without search
        if !mainVM.isSearching(searchText: vehicleSearchBar.text ?? "") {
            let vehicle = mainVM.vehicles[indexPath.row]

            let cellVM = VehicleCellViewModel(name: vehicle.name, model: vehicle.model, image: vehicle.defaultImageURL, make: vehicle.make)
            
            cell.setup(cellViewModel: cellVM)
           
            // configure cell with search
        } else {
            
            let searchedVehicle = mainVM.searchedVehicles[indexPath.row]
            
            let cellVM = VehicleCellViewModel(name: searchedVehicle.name, model: searchedVehicle.model, image: searchedVehicle.defaultImageURL, make: searchedVehicle.make)
            cell.setup(cellViewModel: cellVM)
        }
        
        return cell
    }
    
    // footer which will have spinner
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    // Checking for if the user is at the bottom of the list. Once they pull +1 row at the bottom, a spinner will show up and the next page will load for data
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
    
    // Activating details view on row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = VehicleDetailViewController()
        let navController = UINavigationController(rootViewController: detailVC)
        
        detailVC.title = "Vehicle Details & Location"
        
        if !mainVM.isSearching(searchText: vehicleSearchBar.text ?? "") {
            
            let vehicle = mainVM.vehicles[indexPath.row]
            
            let detailVM = VehicleDetailViewModel(vehicle: vehicle)
            
            detailVC.bindVM(viewModel: detailVM)
            
            self.present(navController, animated: true)
            
        } else {
            
            let searched =  mainVM.searchedVehicles[indexPath.row]
            
            let detailVM = VehicleDetailViewModel(vehicle: searched)
            
            detailVC.bindVM(viewModel: detailVM)
            
            self.present(navController, animated: true)
        }
    }
    
    // We want a consistent height for rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    // Footer spinner
    private func createFooterSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width - 15, height: 50))
        
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



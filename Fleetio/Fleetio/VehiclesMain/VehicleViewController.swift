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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
                self.vehicles.append(contentsOf: data)
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
        mainVM.isRefreshing = true
        tableView.tableFooterView = nil
        
        vehicles.removeAll()
        searchedVehicle.removeAll()
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
            configuration.text = "\(vehicles[indexPath.row].name) + \(indexPath.row)"
        } else {
            configuration.text = searchedVehicle[indexPath.row].name
        }
        
        cell.contentConfiguration = configuration
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == vehicles.count {
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
    
    private func createFooterSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        spinner.color = .fleetioGreen
        
        return footerView
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let position = scrollView.contentOffset.y
//        if position > (self.tableView.contentSize.height-100-scrollView.frame.size.height) {
//            guard !mainVM.isPaginating else {
//                return
//            }
//
//            if self.mainVM.currentPage < self.mainVM.totalPages {
//                self.tableView.tableFooterView = createFooterSpinner()
//                configureVMFetch(pagination: true)
//            } else {
//                self.tableView.tableFooterView = nil
//            }
//        }
//    }
    
}

// Search Functionality
extension VehicleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedVehicle = vehicles.filter({
            var isThere: Bool?
            if let name = $0.name {
                isThere = name.contains(searchText)
            }
            return isThere ?? false
        })
        
        searching = true
        tableView.reloadData()
    }
}



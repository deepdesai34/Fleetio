//
//  ViewController.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import UIKit

class MainViewController: UIViewController {
    
    
    let mainVM = MainViewModel()
    var vehicles = [Vehicle]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = 10
        table.sectionIndexColor = .black
        table.tableFooterView?.isHidden = true
        
        
        return table
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        configureVMData()
        configureViews()
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//    }
    
    func configureViews() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func configureVMData() {
        // Binding data for vehicles from viewModel
        mainVM.getVehicles { newVehicles in
            self.vehicles = newVehicles
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.layer.cornerRadius = 10
        
        view.backgroundColor = .fleetioGreen
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Courier-BoldOblique", size: 25)
        label.textColor = .white
        label.text = "heyyyy"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "hello"
        cell.contentConfiguration = configuration
        

        return cell
    }
}




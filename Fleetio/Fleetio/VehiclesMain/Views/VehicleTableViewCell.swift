//
//  VehicleTableViewCell.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-16.
//

import UIKit
import Kingfisher


class VehicleTableViewCell: UITableViewCell {
    
    // Main Stack
    let mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    // Sub Stacks
    
    let nameStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    let makeStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    
    
    let modelStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    
    // Title Labels
    
    let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.text = "Name"
        
        return label
    }()
    
    let makeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.text = "Make"
        
        return label
    }()
    
    let modelTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.text = "Model"
        
        return label
    }()
    
    
    // Car Image
    
    let vehicleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    
    // Value Labels
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    let makeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    let modelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // View Configuration
    private func configureViews() {
        self.accessoryType = .disclosureIndicator
        self.tintColor = .black
        
        self.backgroundColor = .white
        contentView.addSubview(vehicleImageView)
        contentView.addSubview(mainVStack)
        
        
        // Name Stack
        nameStack.addArrangedSubview(nameTitleLabel)
        nameStack.addArrangedSubview(nameLabel)
        
        // Model Stack
        modelStack.addArrangedSubview(modelTitleLabel)
        modelStack.addArrangedSubview(modelLabel)
        
        // Make Stack
        makeStack.addArrangedSubview(makeTitleLabel)
        makeStack.addArrangedSubview(makeLabel)
        
        //Main Stack
        mainVStack.addArrangedSubview(nameStack)
        mainVStack.addArrangedSubview(makeStack)
        mainVStack.addArrangedSubview(modelStack)
        
        
        // Laying Out Stacks
        
        NSLayoutConstraint.activate([
            vehicleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            vehicleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            vehicleImageView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -30),
            vehicleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
        ])
        
        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: vehicleImageView.trailingAnchor, constant: 20),
            mainVStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainVStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    // View Model Configuration
    func setup(cellViewModel: VehicleCellViewModel) {
        nameLabel.text =  (cellViewModel.name ?? "NA")
        makeLabel.text =  (cellViewModel.make ?? "N/A")
        modelLabel.text = (cellViewModel.model ?? "N/A")
        
        vehicleImageView.cacheImage(imageStringURL: cellViewModel.image)
    }
    
    
}

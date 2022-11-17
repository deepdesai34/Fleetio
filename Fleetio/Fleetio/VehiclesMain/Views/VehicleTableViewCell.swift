//
//  VehicleTableViewCell.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-16.
//

import UIKit
import Kingfisher


class VehicleTableViewCell: UITableViewCell {
    
    // stacks
    let mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        return stack
    }()
    
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
    
    let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Name: "
        
        return label
    }()
    
    let makeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Make: "
        
        return label
    }()
    
    let modelTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Model: "
        
        return label
    }()
    
    
    
    let vehicleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .regular)
        label.textColor = .fleetioGreen
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    let makeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .regular)
        label.textColor = .fleetioGreen
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    let modelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .regular)
        label.textColor = .fleetioGreen
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
        
        
        
        
        
        NSLayoutConstraint.activate([
            vehicleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            vehicleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            vehicleImageView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -20),
            vehicleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
        ])
        
        
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: vehicleImageView.trailingAnchor, constant: 20),
            mainVStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainVStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    
    func setup(cellViewModel: VehicleCellViewModel) {
        nameLabel.text =  (cellViewModel.name ?? "NA")
        makeLabel.text =  (cellViewModel.make ?? "N/A")
        modelLabel.text = (cellViewModel.model ?? "N/A")
        
        vehicleImageView.cacheImage(imageStringURL: cellViewModel.image)
    }
    
    
}

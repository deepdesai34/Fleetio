//
//  VehicleTableViewCell.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-16.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedTitleFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    let modelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedTitleFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    let makeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedTitleFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    let vehicleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        
        return imageView
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(modelLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(vehicleImageView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            // ImageView
            vehicleImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            vehicleImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 6),
            vehicleImageView.trailingAnchor.constraint(equalTo: nameLabel.safeAreaLayoutGuide.leadingAnchor),
            vehicleImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            
            // name
            nameLabel.leadingAnchor.constraint(equalTo: vehicleImageView.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 6),
            nameLabel.trailingAnchor.constraint(equalTo: modelLabel.safeAreaLayoutGuide.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            
            // model
            modelLabel.leadingAnchor.constraint(equalTo: nameLabel.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            modelLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 6),
            modelLabel.leadingAnchor.constraint(equalTo: modelLabel.safeAreaLayoutGuide.leadingAnchor),
            modelLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            
            
            // make
            modelLabel.leadingAnchor.constraint(equalTo: nameLabel.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            modelLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 6),
            modelLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -6),
            modelLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            
        ])
    }
    
}

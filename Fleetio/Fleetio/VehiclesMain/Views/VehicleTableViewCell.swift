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
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    let makeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    
    let modelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        
        return label
    }()
    
    let vehicleImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 5
            imageView.backgroundColor = .black
    
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(makeLabel)
        contentView.addSubview(modelLabel)
        contentView.addSubview(vehicleImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            makeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            makeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            makeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            modelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            modelLabel.leadingAnchor.constraint(equalTo: makeLabel.trailingAnchor),
            modelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        
    }
    
    func setup(cellViewModel: VehicleCellViewModel) {
        nameLabel.text = "Name: " + (cellViewModel.name ?? "NA")
        makeLabel.text = "Make: " + (cellViewModel.make ?? "N/A")
        modelLabel.text = "Model: " + (cellViewModel.model ?? "N/A")
    }
    
    
}

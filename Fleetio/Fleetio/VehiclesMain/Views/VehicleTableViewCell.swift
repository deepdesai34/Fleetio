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
        
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
}

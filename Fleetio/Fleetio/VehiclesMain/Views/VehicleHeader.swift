//
//  VehicleHeader.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-15.
//

import UIKit

class VehicleHeader: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedTitleFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(viewModel: VehicleHeaderViewModel) {
        configureViews(name: viewModel.vehicleName)
        print()
    }
    
    
    func configureViews(name: String) {
        
        addSubview(titleLabel)
        titleLabel.text = name
        self.backgroundColor = .fleetioGreen
        
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    
}

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
        label.font = .roundedTitleFont(ofSize: 15, weight: .semibold)
        label.textColor = .fleetioGreen
        label.text = "Name: "
        
        return label
    }()
    
    let makeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .semibold)
        label.textColor = .fleetioGreen
        label.text = "Make: "
        
        return label
    }()
    
    let modelTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .semibold)
        label.textColor = .fleetioGreen
        label.text = "Model: "
        
        return label
    }()
    
    
    
    let vehicleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .light)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    let makeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .light)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    let modelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedTitleFont(ofSize: 15, weight: .light)
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
        self.backgroundColor = .black.withAlphaComponent(0.75)
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
        
        let url = URL(string: "https://d8g9nhlfs6lwh.cloudfront.net/ICM5IE9QT8WM1fWCGKhr?signature=e1bf387376847dc881ac46d80ac0ca089532483f5f55b64305fc232b5d0b5488&policy=eyJoYW5kbGUiOiJJQ001SUU5UVQ4V00xZldDR0tociIsImV4cGlyeSI6NDUzNDk0OTM0MywiY2FsbCI6WyJyZWFkIl19")
        let processor = DownsamplingImageProcessor(size: vehicleImageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        vehicleImageView.kf.indicatorType = .activity
        vehicleImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    
}

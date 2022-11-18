//
//  Table+Extensions.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-17.
//

import Foundation
import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        messageLabel.text = message
        messageLabel.textColor = .fleetioGreen
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.roundedTitleFont(ofSize: 15, weight: .bold)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

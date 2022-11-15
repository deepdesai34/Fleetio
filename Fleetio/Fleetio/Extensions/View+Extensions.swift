//
//  View+Extensions.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-14.
//

import Foundation
import UIKit

// Extension to pin view to top, bottom, leading, and trailing anchors
extension UIView {
    func pinToSuperView(superView: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

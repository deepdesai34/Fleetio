//
//  Image+Extensions.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-14.
//

import Foundation
import UIKit

extension UIImage {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self = image
                    }
                }
            }
        }
    }
}

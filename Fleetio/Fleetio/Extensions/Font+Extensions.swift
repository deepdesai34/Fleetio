//
//  Font+Extensions.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-15.
//

import Foundation
import UIKit

// Custom Fonts
extension UIFont {
    static func roundedTitleFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        let font: UIFont

            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                font = UIFont(descriptor: descriptor, size: fontSize)
            } else {
                font = systemFont
            }

        return font
    }
}

//
//  Image+Extensions.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-14.
//

import Foundation
import UIKit


//extension UIImageView {
    
//    func load(urlString: String) {
//        if let url = URL(string: urlString){
//            DispatchQueue.global().async { [weak self] in
//                if let data = try? Data(contentsOf: url) {
//                    if let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            self?.image = image
//                        }
//                    }
//                }
//            }
//
//        } else {
//            self.image = UIImage(systemName: "nosign.app")
//            self.tintColor = .fleetioGrey
//
//        }
//
//
//    }
//
//
//
//}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        if let url = URL(string: URLAddress) {
            
            DispatchQueue.main.async { [weak self] in
                if let imageData = try? Data(contentsOf: url) {
                    if let loadedImage = UIImage(data: imageData) {
                            self?.image = loadedImage
                    }
                }
            }
        } else {
            self.image = UIImage(systemName: "nosign.app")
            self.tintColor = .fleetioGrey
        }
        

    }
}




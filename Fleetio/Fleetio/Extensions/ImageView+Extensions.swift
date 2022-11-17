//
//  Image+Extensions.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-14.
//

import Foundation
import UIKit
import Kingfisher


extension UIImageView {
    
    func cacheImage(imageStringURL: String?) {
        
        if let newImageStringURL = imageStringURL {
            
            let url = URL(string: newImageStringURL)
            
            let processor = DownsamplingImageProcessor(size: CGSize(width: 100, height: 100))
            |> RoundCornerImageProcessor(cornerRadius: 10)
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]) {
                
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        } else {
            self.image = UIImage(named: "NoImage")
            self.tintColor = .fleetioGrey
        }
        

    }
    
}


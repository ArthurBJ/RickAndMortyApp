//
//  UIImageView + Utils.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import UIKit

extension UIImageView {
    
    func setImageFromData(data: Data?) {
        if let data = data {
            if let image = UIImage(data: data) {
                self.image = image
            }
        }
    }
    
    func addDefaultImage() {
        image = UIImage(named: "default")
    }
}

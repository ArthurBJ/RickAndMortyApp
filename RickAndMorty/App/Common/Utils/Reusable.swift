//
//  Reusable.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 19.11.2023.
//

import Foundation

protocol Reusable {}

extension Reusable {
    static var reuseId: String {
        String(describing: self)
    }
}

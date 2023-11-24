//
//  PropertyIterator.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import Foundation
/// Рефлексия

protocol PropertyIterator {}

extension PropertyIterator {
    
    func dictionaryProperties() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary: [String: Any] = [:]
        
        mirror.children.forEach { property in
            dictionary[property.label ?? ""] = property.value
        }
        
        return dictionary
    }
}

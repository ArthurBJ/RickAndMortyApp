//
//  LocationTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import Foundation

struct LocationTableViewCellViewModel {
    
    private(set) var location: Location
    
    var name: String {
        location.name
    }
    
    var dimension: String {
        return "Dimension " + (location.dimension ?? AppLocalized.unknown)
    }
    
    var type: String {
        return "Type: " + (location.type ?? AppLocalized.unknown)
    }
}

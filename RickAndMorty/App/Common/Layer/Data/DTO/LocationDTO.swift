//
//  LocationDTO.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

struct LocationDTO: Decodable {
    let name: String
    let type: String?
    let dimension: String?
    let url: String
}

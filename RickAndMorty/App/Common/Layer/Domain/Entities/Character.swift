//
//  Character.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import Foundation

struct Character {
    let id: Int
    let name: String
    let status: StatusCharacter?
    let specie: Specie
    let urlCharacter: String
    let urlImage: String?
    let origin: Origin
    let loaction: Location
}

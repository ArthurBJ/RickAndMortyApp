//
//  HttpResponseStatus.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import Foundation

enum HttpResponseStatus {
    static let ok = 200...299
    static let clientError = 400...499
    static let serverError = 500...599
}

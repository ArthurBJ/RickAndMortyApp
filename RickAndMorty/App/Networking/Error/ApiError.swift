//
//  ApiError.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import Foundation

enum ApiError: Error {
    case clientError
    case serverError
    case unknownError
    case errorInUrl
    case errorDecoding
}

extension ApiError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .clientError:
            return NSLocalizedString("Client error", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .errorInUrl:
            return NSLocalizedString("Url error", comment: "")
        case .errorDecoding:
            return NSLocalizedString("Decoding error", comment: "")
        }
    }
}

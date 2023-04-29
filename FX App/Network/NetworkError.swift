//
//  NetworkError.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

/// The different error types that might occur when making network calls
enum NetworkError: Error {
    
    case badUrl
    case badRequest
    case decodingError
    case noData
    case customError(Error)
    
    var message: String {
        switch self {
        case .badUrl:
            return "The url that was provided is invalid"
        case .decodingError:
            return "There was an error decoding the data"
        case .badRequest:
            return "The request that was sent is invalid"
        case .noData:
            return "There was no data returned from the server"
        case .customError(let error):
            return error.localizedDescription
        }
    }
    
}

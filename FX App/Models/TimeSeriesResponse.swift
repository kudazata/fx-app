//
//  TimeSeriesResponse.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

struct TimeSeriesResponse: Codable {
    
    let endDate: String?
    let startDate: String?
    let price: [String: [String: Float]]?
    let error: TimeSeriesError?
    
}

struct TimeSeriesError: Codable {
    let code: String
    let info: String
}

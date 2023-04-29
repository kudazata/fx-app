//
//  TimeSeriesResponse.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

struct TimeSeriesResponse: Codable {
    
    let endDate: String
    let startDate: String
    let price: [String: [String: String]]
    
}

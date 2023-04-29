//
//  ExchangeRate.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

struct ExchangeRate: Codable {
    let from: String
    let price: Double
    let timestamp: Int
    let to: String
    let total: Double
}

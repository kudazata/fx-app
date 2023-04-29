//
//  CurrenciesResponse.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

struct CurrenciesResponse: Codable {
    let currencies: [String: String]
}

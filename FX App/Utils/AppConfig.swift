//
//  AppConfig.swift
//  FX App
//
//  Created by Kuda Zata on 22/2/2025.
//

import Foundation

struct AppConfig {
    static var apiKey: String? {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    }
}

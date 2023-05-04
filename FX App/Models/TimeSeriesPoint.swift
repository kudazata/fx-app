//
//  TimeSeriesPoint.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

struct TimeSeriesPoint: Identifiable {
    
    var id: Date {
        return self.date
    }
    
    var date: Date
    var exchangeRate: Float
}

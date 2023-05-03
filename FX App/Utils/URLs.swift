//
//  URLs.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

struct URLs {
    
    static let apiKey = "Rpjs1n6QAGgR9ZOr8cHh"
    static let baseUrl = "https://fxmarketapi.com/"
    
    static let getCurrenciesUrl = baseUrl + "apicurrencies?api_key=" + apiKey
    
    static func getExchangeRateUrl(from: String, to: String) -> String {
        return baseUrl + "apiconvert?api_key=" + apiKey + "&from=\(from)&to=" + to + "&amount=1"
    }
    
    static func getTimeSeriesUrl(from: String, to: String, dates: [String]) -> String {
        
        let url = baseUrl + "apitimeseries?api_key=" + apiKey + "&currency=" + from + to + "&start_date=" + dates[0] + "&end_date=" + dates[1] + "&format=close"
        print(url)
        return url
    }
    
    static func getDatesForTimeSeries() -> [String] {
        
        var currentDate = Date()
        let calendar = Calendar.current
        var currentDateComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: currentDate)
        
        if currentDateComponents.weekday == 1 || currentDateComponents.weekday == 7 {
            currentDateComponents.day! -= currentDateComponents.weekday! - 6
            currentDate = calendar.date(from: currentDateComponents)!
        }
        
        var previousDate = calendar.date(byAdding: .day, value: -30, to: currentDate)!
        var previousDateComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: previousDate)
        
        if previousDateComponents.weekday == 1 || previousDateComponents.weekday == 7 {
            previousDateComponents.day! += 9 - previousDateComponents.weekday!
            previousDate = calendar.date(from: previousDateComponents)!
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDateString = dateFormatter.string(from: currentDate)
        let previousDateString = dateFormatter.string(from: previousDate)
        
        return [previousDateString, currentDateString]
    }
}

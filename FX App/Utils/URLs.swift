//
//  URLs.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

struct URLs {
    
    static let apiKey = "HIGCTFwyNihKl6dVfNVn"
    static let baseUrl = "https://fxmarketapi.com/"
    
    static let getCurrenciesUrl = baseUrl + "apicurrencies?api_key=" + apiKey
    
    static func getExchangeRateUrl(from: String, to: String) -> String {
        return baseUrl + "apiconvert?api_key=" + apiKey + "&from=\(from)&to=" + to + "&amount=1"
    }
    
    static func getTimeSeriesUrl(from: String, to: String, dates: [String]) -> String {
        return baseUrl + "apitimeseries?api_key=" + apiKey + "&currency=" + from + to + "&start_date=" + dates[0] + "&end_date=" + dates[1] + "&format=close"
    }
    
    /// This helper function calculates today's date as well as the date from 30 days ago, but excludes weekends because the api does not take weekend dates
    /// - Returns: an array of to strings: today's date and the date 30 days ago 
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

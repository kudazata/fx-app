//
//  NetworkServiceMock.swift
//  FX AppTests
//
//  Created by Kuda Zata on 2/5/2023.
//

import Foundation
@testable import FX_App

struct NetworkServiceMock: NetworkServiceProtocol {
    
    var shouldFail = false
    
    func getCurrencies(completion: @escaping (Result<CurrenciesResponse?, NetworkError>) -> Void) {
        
        if shouldFail {
            completion(.failure(.noData))
        }
        else {
            let currencies = [
                "USDAED": "United Arab Emirates Dirham",
                "USDARS": "Argentine Peso",
                "USDAUD": "Australian Dollar",
                "USDBRL": "Brazilian Real",
                "BTCUSD": "Bitcoin",
                "USDCAD": "Canadian Dollar",
                "USDCHF": "Swiss Franc",
                "USDCLP": "Chilean Peso",
                "USDCNY": "Chinese Yuan",
                "USDCOP": "Colombian Peso",
                "USDCZK": "Czech Koruna",
                "USDDKK": "Danish Krone",
                "USDEUR": "Euro",
                "USDGBP": "British Pound Sterling",
                "USDHKD": "Hong Kong Dollar",
                "USDHUF": "Hungarian Forint",
                "USDHRK": "Croatian Kuna",
                "USDIDR": "Indonesian Rupiah",
                "USDILS": "Israeli Sheqel",
                "USDINR": "Indian Rupee",
                "USDISK": "Icelandic Krona",
                "USDJPY": "Japanese Yen",
                "USDKRW": "South Korean Won",
                "USDKWD": "Kuwaiti Dinar",
                "USDMXN": "Mexican Peso",
                "USDMYR": "Malaysian Ringgit",
                "USDMAD": "Moroccan Dirham",
                "USDNOK": "Norwegian Krone",
                "USDNZD": "New Zealand Dollar",
                "USDPEN": "Peruvian Nuevo Sol",
                "USDPHP": "Philippine Peso",
                "USDPLN": "Polish Zloty",
                "USDRON": "Romanian Leu",
                "USDRUB": "Russian Ruble",
                "USDSEK": "Swedish Krona",
                "USDSGD": "Singapore Dollar",
                "USDTHB": "Thai Baht",
                "USDTRY": "Turkish Lira",
                "USDTWD": "Taiwanese Dollar",
                "USDXAG": "Silver (ounce)",
                "USDXAU": "Gold (ounce)",
                "USDZAR": "South African Rand"
            ]
            
            let currenciesResponse = CurrenciesResponse(currencies: currencies)
            
            completion(.success(currenciesResponse))
        }
        
    }
    
    func getExchangeRate(from: String, to: String, completion: @escaping (Result<ExchangeRate?, NetworkError>) -> Void) {
        
        if shouldFail {
            completion(.failure(.noData))
        }
        else {
            let exchangeRate = ExchangeRate(from: "USD", price: 18.55, timestamp: 1683100645, to: "ZAR", total: 18.55)
            completion(.success(exchangeRate))
        }
    }
    
    func getTimeSeries(from: Currency, to: Currency, completion: @escaping (Result<TimeSeriesResponse?, NetworkError>) -> Void) {
    }
    
    
}

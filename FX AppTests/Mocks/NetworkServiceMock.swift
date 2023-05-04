//
//  NetworkServiceMock.swift
//  FX AppTests
//
//  Created by Kuda Zata on 2/5/2023.
//

import Foundation
@testable import FX_App
import Combine

struct NetworkServiceMock: NetworkServiceProtocol {
    
    var shouldFail = false
    
    func getCurrencies() -> AnyPublisher<CurrenciesResponse, NetworkError> {
        
        if shouldFail {
            return Fail(error: NetworkError.noData).eraseToAnyPublisher()
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
            
            return Just(currenciesResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
    }
    
    func getExchangeRate(from: String, to: String) -> AnyPublisher<ExchangeRate, NetworkError> {
        
        if shouldFail {
            return Fail(error: NetworkError.noData).eraseToAnyPublisher()
        }
        else {
            
            let exchangeRate = ExchangeRate(from: "USD", price: 18.55, timestamp: 1683100645, to: "ZAR", total: 18.55)
            
            return Just(exchangeRate)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
    }
    
    func getTimeSeries(from: String, to: String) -> AnyPublisher<TimeSeriesResponse, NetworkError> {
        
        if shouldFail {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }
        else {
            
            let prices: [String: [String: Float]] = [
                "2023-04-03": [
                    "USDZAR": 17.8495
                ],
                "2023-04-04": [
                    "USDZAR": 17.91779
                ],
                "2023-04-05": [
                    "USDZAR": 18.0545
                ],
                "2023-04-06": [
                    "USDZAR": 18.23125
                ],
                "2023-04-07": [
                    "USDZAR": 18.1948
                ],
                "2023-04-10": [
                    "USDZAR": 18.49018
                ],
                "2023-04-11": [
                    "USDZAR": 18.37177
                ],
                "2023-04-12": [
                    "USDZAR": 18.43491
                ],
                "2023-04-13": [
                    "USDZAR": 18.05616
                ],
                "2023-04-14": [
                    "USDZAR": 18.07762
                ],
                "2023-04-17": [
                    "USDZAR": 18.31941
                ],
                "2023-04-18": [
                    "USDZAR": 18.16352
                ],
                "2023-04-19": [
                    "USDZAR": 18.168
                ],
                "2023-04-20": [
                    "USDZAR": 18.03875
                ],
                "2023-04-21": [
                    "USDZAR": 18.08279
                ],
                "2023-04-24": [
                    "USDZAR": 18.13599
                ],
                "2023-04-25": [
                    "USDZAR": 18.34103
                ],
                "2023-04-26": [
                    "USDZAR": 18.4122
                ],
                "2023-04-27": [
                    "USDZAR": 18.3048
                ],
                "2023-04-28": [
                    "USDZAR": 18.2888
                ],
                "2023-05-01": [
                    "USDZAR": 18.40175
                ],
                "2023-05-02": [
                    "USDZAR": 18.475
                ],
                "2023-05-03": [
                    "USDZAR": 18.29788
                ]
                
            ]
            
            let timeSeriesResponse = TimeSeriesResponse(endDate: "2023-05-03", startDate: "2023-04-03", price: prices, error: nil)
            
            return Just(timeSeriesResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            
        }
    }
    
    
}

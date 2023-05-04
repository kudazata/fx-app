//
//  NetworkService.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation
import Combine

struct NetworkService: NetworkServiceProtocol {
    
    /// Network function to get currencies from the server
    /// - Returns: <#description#>
    func getCurrencies() -> AnyPublisher<CurrenciesResponse, NetworkError> {
        
        let urlString = URLs.getCurrenciesUrl
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: CurrenciesResponse.self, decoder: JSONDecoder())
            .map {
                $0 as CurrenciesResponse
            }
            .mapError { error -> NetworkError in
                return NetworkError.customError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    
    /// Network function to get an exchange rate from the server
    /// - Parameters:
    ///    - from: The base currency
    ///    - to: the currency being converted to
    /// - Returns: <#description#>
    func getExchangeRate(from: String, to: String) -> AnyPublisher<ExchangeRate, NetworkError> {
        
        let urlString = URLs.getExchangeRateUrl(from: from, to: to)
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: ExchangeRate.self, decoder: JSONDecoder())
            .map {
                $0 as ExchangeRate
            }
            .mapError { error -> NetworkError in
                switch error {
                case is DecodingError:
                    return NetworkError.decodingError
                default:
                    return NetworkError.customError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    /// Network function to get a time series of exchange rates from the server
    /// - Parameters:
    ///    - from: The base currency
    ///    - to: the currency being converted to
    /// - Returns: <#description#>
    func getTimeSeries(from: String, to: String) -> AnyPublisher<TimeSeriesResponse, NetworkError> {
        
        let dates = URLs.getDatesForTimeSeries()
        let urlString = URLs.getTimeSeriesUrl(from: from, to: to, dates: dates)
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: TimeSeriesResponse.self, decoder: decoder)
            .map {
                $0 as TimeSeriesResponse
            }
            .mapError { error -> NetworkError in
                switch error {
                case is DecodingError:
                    return NetworkError.decodingError
                default:
                    return NetworkError.customError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    
}

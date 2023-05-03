//
//  NetworkService.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

struct NetworkService: NetworkServiceProtocol {
    
    /// Generic network caller that can take in and return any type of object
    /// - Parameters:
    ///    - resource: object of type GenericResource to be used for the network call
    ///    - completion: Code to be executed by the caller. Will contain type Result
    func makeNetworkCall<T>(resource: GenericResource<T>, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        
        guard let url = URL(string: resource.urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            guard (200..<300).contains(statusCode) else {
                completion(.failure(.badRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(resource.parse(data)))
            }
        }.resume()
        
    }
    
    /// Network function to get currencies from the server
    /// - Parameters:
    ///    - completion: Code to be executed by the caller. Will contain type Result
    func getCurrencies(completion: @escaping (Result<CurrenciesResponse?, NetworkError>) -> Void) {
        
        let resource = GenericResource<CurrenciesResponse>(urlString: URLs.getCurrenciesUrl) { data in
            do {
                let currenciesResponse = try JSONDecoder().decode(CurrenciesResponse.self, from: data)
                return currenciesResponse
            }
            catch {
                completion(.failure(.decodingError))
                return nil
            }
        }
        
        makeNetworkCall(resource: resource) { result in
            switch result {
            case let .success(currenciesResponse):
                completion(.success(currenciesResponse))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    /// Network function to get an exchange rate from the server
    /// - Parameters:
    ///    - from: The base currency
    ///    - to: the currency being converted to
    ///    - completion: Code to be executed by the caller. Will contain type Result
    func getExchangeRate(from: String, to: String, completion: @escaping (Result<ExchangeRate?, NetworkError>) -> Void) {
        
        let urlString = URLs.getExchangeRateUrl(from: from, to: to)
        let resource = GenericResource<ExchangeRate>(urlString: urlString) { data in
            do {
                let exchangeRate = try JSONDecoder().decode(ExchangeRate.self, from: data)
                return exchangeRate
            }
            catch {
                completion(.failure(.decodingError))
                return nil
            }
        }
        
        makeNetworkCall(resource: resource) { result in
            switch result {
            case let .success(exchangeRate):
                completion(.success(exchangeRate))
            case let .failure(error):
                completion(.failure(error))
            }
        }
        
    }
    
    
    /// Network function to get a time series of exchange rates from the server
    /// - Parameters:
    ///    - from: The base currency
    ///    - to: the currency being converted to
    ///    - completion: Code to be executed by the caller. Will contain type Result
    func getTimeSeries(from: Currency, to: Currency, completion: @escaping (Result<TimeSeriesResponse?, NetworkError>) -> Void) {
        
        let dates = URLs.getDates()
        let urlString = URLs.getTimeSeriesUrl(from: from, to: to, dates: dates)
        let resource = GenericResource<TimeSeriesResponse>(urlString: urlString) { data in
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let timeSeriesResponse = try decoder.decode(TimeSeriesResponse.self, from: data)
                return timeSeriesResponse
            }
            catch {
                completion(.failure(.decodingError))
                return nil
            }
        }
        
        makeNetworkCall(resource: resource) { result in
            switch result {
            case let .success(timeSeriesResponse):
                completion(.success(timeSeriesResponse))
            case let.failure(error):
                completion(.failure(error))
            }
        }
    }
    
    
}

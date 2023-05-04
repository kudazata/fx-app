//
//  NetworkServiceProtocol.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func getCurrencies() -> AnyPublisher<CurrenciesResponse, NetworkError>
    func getExchangeRate(from: String, to: String) -> AnyPublisher<ExchangeRate, NetworkError> 
    func getTimeSeries(from: String, to: String) -> AnyPublisher<TimeSeriesResponse, NetworkError>
}

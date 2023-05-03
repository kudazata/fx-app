//
//  NetworkServiceProtocol.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCurrencies(completion: @escaping (Result<CurrenciesResponse?, NetworkError>) -> Void)
    func getExchangeRate(from: String, to: String, completion: @escaping (Result<ExchangeRate?, NetworkError>) -> Void)
    func getTimeSeries(from: String, to: String, completion: @escaping (Result<TimeSeriesResponse?, NetworkError>) -> Void)
}

//
//  MainViewModel.swift
//  FX App
//
//  Created by Kuda Zata on 2/5/2023.
//

import Foundation
import Combine

class MainViewModel {
    
    private var availableCurrencies = [Currency]()
    var currencyNamesArray = [String]()
    var currencyCodesArray = [String]()
    var networkService: NetworkServiceProtocol
    
    let networkErrorPublisher = PassthroughSubject<String, Never>()
    let timeSeriesErrorPublisher = PassthroughSubject<String, Never>()
    let showActivityIndicator = PassthroughSubject<Bool, Never>()
    let currenciesPublisher = PassthroughSubject<[Currency], Never>()
    let exchangeRatePublisher = PassthroughSubject<ExchangeRate, Never>()
    let timeSeriesPublisher = PassthroughSubject<[TimeSeriesPoint], Never>()
    private let dispatchGroup = DispatchGroup()
    
    var timeSeriesArray: [TimeSeriesPoint]?
    var exchangeRate: ExchangeRate?
    var networkError: NetworkError?
    var timeSeriesError: String?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    
    func getCurrencies() {
        showActivityIndicator.send(true)
        networkService.getCurrencies(completion: { result in
            self.showActivityIndicator.send(false)
            switch result {
            case let .success(currenciesResponse):
                if let response = currenciesResponse {
                    self.populateCurrencies(currenciesResponse: response)
                }
            case let  .failure(error):
                self.networkError = error
                self.networkErrorPublisher.send(error.message)
            }
        })
    }
    
    private func populateCurrencies(currenciesResponse: CurrenciesResponse) {
        for (key, value) in currenciesResponse.currencies {
            let currency = Currency(currencyCode: key.replacingOccurrences(of: "USD", with: ""), currencyName: value)
            availableCurrencies.append(currency)
        }
        
        ///manually add USD because API doesn't include it
        let usdCurrency = Currency(currencyCode: "USD", currencyName: "United States Dollar")
        availableCurrencies.append(usdCurrency)
        
        availableCurrencies = availableCurrencies.sorted {$0.currencyName.lowercased() < $1.currencyName.lowercased()}
        
        currencyNamesArray = availableCurrencies.map { $0.currencyName }
        currencyCodesArray = availableCurrencies.map { $0.currencyCode }
        currenciesPublisher.send(availableCurrencies)
    }
    
    func getExchangeRateAndTimeSeries(from: String, to: String) {
        
        timeSeriesArray = nil
        exchangeRate = nil
        
        self.getExchangeRate(from: from, to: to)
        self.getTimeSeries(from: from, to: to)
        
        showActivityIndicator.send(true)
        self.dispatchGroup.notify(queue: .main) {
            self.showActivityIndicator.send(false)
            if let error = self.networkError {
                self.networkErrorPublisher.send(error.message)
                return
            }
            if let exchangeRate = self.exchangeRate {
                self.exchangeRatePublisher.send(exchangeRate)
            }
            
            if let timeSeriesPoints = self.timeSeriesArray {
                self.timeSeriesPublisher.send(timeSeriesPoints)
            }
            else {
                self.timeSeriesErrorPublisher.send("Historical charts are not supported for this exchange rate")
            }
        }
    }
    
    func getExchangeRate(from: String, to: String) {
        dispatchGroup.enter()
        networkService.getExchangeRate(from: from, to: to) { result in
            switch result {
            case let .success(exchangeRate):
                if let exchangeRate = exchangeRate {
                    self.exchangeRate = exchangeRate
                }
            case let .failure(error):
                self.networkError = error
                self.networkErrorPublisher.send(error.message)
            }
            self.dispatchGroup.leave()
        }
    }
    
    func getTimeSeries(from: String, to: String) {
        dispatchGroup.enter()
        networkService.getTimeSeries(from: from, to: to) { result in
            switch result {
            case let .success(timeSeriesResponse):
                if let timeSeriesResponse = timeSeriesResponse {
                    self.populateTimeSeries(series: timeSeriesResponse)
                }
            case let .failure(error):
                self.networkError = error
                self.dispatchGroup.leave()
            }
        }
    }
    
    private func populateTimeSeries(series: TimeSeriesResponse) {

        var timePoints = [TimeSeriesPoint]()
        
        guard let prices = series.price else {
            dispatchGroup.leave()
            return
        }

        for (key, value) in prices {
            let date = convertStringToDate(dateString: key)
            var timePoint = TimeSeriesPoint(date: date, exchangeRate: 0)
            for (_, value) in value {
                timePoint.exchangeRate = value
            }
            timePoints.append(timePoint)
        }

        let sortedTimePoints = timePoints.sorted {$1.date > $0.date}
        self.timeSeriesArray = sortedTimePoints
        self.dispatchGroup.leave()
        
    }
}

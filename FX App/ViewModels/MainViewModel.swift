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
    var timeSeriesArray: [TimeSeriesPoint]?
    var exchangeRate: ExchangeRate?
    var networkError: NetworkError?
    var timeSeriesError: String?
    var cancellables = Set<AnyCancellable>()
    
    private let dispatchGroup = DispatchGroup()
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    
    //MARK: - Network functions
    
    /// This function is used to get the available currencies using the NetworkService struct
    func getCurrencies() {
        showActivityIndicator.send(true)
        
        networkService.getCurrencies()
            .sink { [weak self] completion in
                self?.showActivityIndicator.send(false)
                switch completion {
                case .finished:
                    print("done")
                case .failure(let error):
                    self?.networkError = error
                    self?.networkErrorPublisher.send(error.message)
                }
            } receiveValue: { [weak self] currenciesResponse in
                self?.populateCurrencies(currenciesResponse: currenciesResponse)
            }.store(in: &cancellables)

    }
    
    /// This function is used to get an exchange rate object
    /// - Parameters:
    ///   - from: the code for the currency being converted from eg USD
    ///   - to: the code for the currency being converted to eg ZAR
    func getExchangeRate(from: String, to: String) {
        dispatchGroup.enter()
        networkService.getExchangeRate(from: from, to: to)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("done")
                case .failure(let error):
                    self?.networkError = error
                }
                self?.dispatchGroup.leave()
            } receiveValue: { [weak self] exchangeRate in
                self?.exchangeRate = exchangeRate
            }.store(in: &cancellables)
    }
    
    /// Get a time series for a particular exchange rate
    /// - Parameters:
    ///   - from: the code for the currency being converted from eg USD
    ///   - to: the code for the currency being converted to eg ZAR
    func getTimeSeries(from: String, to: String) {
        self.dispatchGroup.enter()
        networkService.getTimeSeries(from: from, to: to)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    self?.networkError = error
                }
                self?.dispatchGroup.leave()
            } receiveValue: { [weak self] timeSeriesResponse in
                self?.populateTimeSeries(series: timeSeriesResponse)
            }.store(in: &cancellables)
    }
    
    /// This function makes a call to two network functions and makes use of a dispatch group to make these calls at the same time
    /// - Parameters:
    ///   - from: the currency being converted from eg USD
    ///   - to: the currency being converted to eg ZAR
    func getExchangeRateAndTimeSeries(from: String, to: String) {
        
        timeSeriesArray = nil
        exchangeRate = nil
        networkError = nil
        
        self.getExchangeRate(from: from, to: to)
        self.getTimeSeries(from: from, to: to)

        showActivityIndicator.send(true)
        
        self.dispatchGroup.notify(queue: .main) {
            self.showActivityIndicator.send(false)
            if let error = self.networkError {
                self.networkErrorPublisher.send(error.message)
                //return
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
    
    //MARK: - Helper functions
    
    /// This function converts the network response from getting currencies into local usable objects of type [Currency] and [String]
    /// - Parameter currenciesResponse: response object that comes from network call
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
    
    /// This function converts the time series response object into a usable array of type [TimeSeriesPoint]
    /// - Parameter series: the response object that comes from the network call
    private func populateTimeSeries(series: TimeSeriesResponse) {

        var timePoints = [TimeSeriesPoint]()
        
        guard let prices = series.price else {
            return
        }

        for (key, value) in prices {
            let date = key.convertToDate()
            var timePoint = TimeSeriesPoint(date: date, exchangeRate: 0)
            for (_, value) in value {
                timePoint.exchangeRate = value
            }
            timePoints.append(timePoint)
        }

        let sortedTimePoints = timePoints.sorted {$1.date > $0.date}
        self.timeSeriesArray = sortedTimePoints
        
    }
}

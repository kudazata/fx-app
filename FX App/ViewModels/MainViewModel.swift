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
    
    let networkError = PassthroughSubject<String, Never>()
    let showActivityIndicator = PassthroughSubject<Bool, Never>()
    let currencies = PassthroughSubject<[Currency], Never>()
    
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
                self.networkError.send(error.message)
            }
        })
    }
    
    private func populateCurrencies(currenciesResponse: CurrenciesResponse) {
        for (key, value) in currenciesResponse.currencies {
            let currency = Currency(currencyCode: key.replacingOccurrences(of: "USD", with: ""), currencyName: value)
            availableCurrencies.append(currency)
        }
        
        availableCurrencies = availableCurrencies.sorted {$0.currencyName.lowercased() < $1.currencyName.lowercased()}
        
        currencyNamesArray = availableCurrencies.map { $0.currencyName }
        currencyCodesArray = availableCurrencies.map { $0.currencyCode }
        currencies.send(availableCurrencies)
    }
}

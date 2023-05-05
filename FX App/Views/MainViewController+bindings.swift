//
//  MainViewController+bindings.swift
//  FX App
//
//  Created by Kuda Zata on 4/5/2023.
//

import Foundation

extension MainViewController {
    
    ///This function is responsible for all View Model bindings
    func bindViewModel() {
        
        mainViewModel.networkErrorPublisher.sink { [weak self] errorMessage in
            self?.showGeneralAlert(title: "Error", message: errorMessage)
        }.store(in: &cancellables)
        
        mainViewModel.showActivityIndicator.sink { [weak self] showIndicator in
            if showIndicator {
                self?.activityIndicator.startAnimating()
            }
            else {
                self?.activityIndicator.stopAnimating()
            }
        }.store(in: &cancellables)
        
        mainViewModel.currenciesPublisher.sink { [weak self] _ in
            if let self = self {
                self.setupDropDowns(currencies: self.mainViewModel.currencyNamesArray)
            }
        }.store(in: &cancellables)
        
        mainViewModel.exchangeRatePublisher.sink { [weak self] exchangeRate in
            self?.exchangeRateView.isHidden = false
            self?.exchangeRateLabel.text = "1 \(exchangeRate.from) = \(exchangeRate.total.toStringWithTwoDecimalPlaces()) \(exchangeRate.to)"
        }.store(in: &cancellables)
        
        mainViewModel.timeSeriesPublisher.sink { [weak self] timeSeriesArray in
            self?.setupGraphView(timeSeriesArray: timeSeriesArray)
        }.store(in: &cancellables)
        
        mainViewModel.timeSeriesErrorPublisher.sink { [weak self] errorMessage in
            self?.timeSeriesErrorLabel.isHidden = false
            self?.timeSeriesErrorLabel.text = errorMessage
        }.store(in: &cancellables)
        
    }
}

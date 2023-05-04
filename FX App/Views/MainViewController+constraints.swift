//
//  MainViewController+constraints.swift
//  FX App
//
//  Created by Kuda Zata on 4/5/2023.
//

import Foundation
import UIKit

extension MainViewController {
    
    ///This function is responsible for setting up the constraints for this view controller
    func setupConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        fromView.translatesAutoresizingMaskIntoConstraints = false
        toView.translatesAutoresizingMaskIntoConstraints = false
        fromDownArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        toDownArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        fromCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        toCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        getExchangeRateButton.translatesAutoresizingMaskIntoConstraints = false
        exchangeRateView.translatesAutoresizingMaskIntoConstraints = false
        exchangeRateLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        timeSeriesErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            fromLabel.leadingAnchor.constraint(equalTo: fromView.leadingAnchor, constant: 0),
            fromLabel.bottomAnchor.constraint(equalTo: fromView.topAnchor, constant: 0),
            fromView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            fromView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            fromView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05),
            fromView.heightAnchor.constraint(equalToConstant: 50),
            fromCurrencyLabel.leadingAnchor.constraint(equalTo: fromView.leadingAnchor, constant: 15),
            fromCurrencyLabel.centerYAnchor.constraint(equalTo: fromView.centerYAnchor),
            fromDownArrowImageView.trailingAnchor.constraint(equalTo: fromView.trailingAnchor, constant: -15),
            fromDownArrowImageView.heightAnchor.constraint(equalToConstant: 15),
            fromDownArrowImageView.widthAnchor.constraint(equalToConstant: 20),
            fromDownArrowImageView.centerYAnchor.constraint(equalTo: fromView.centerYAnchor),
            toLabel.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: 0),
            toLabel.bottomAnchor.constraint(equalTo: toView.topAnchor, constant: 0),
            toView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            toView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            toView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05),
            toView.heightAnchor.constraint(equalToConstant: 50),
            toCurrencyLabel.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: 15),
            toCurrencyLabel.centerYAnchor.constraint(equalTo: toView.centerYAnchor),
            toDownArrowImageView.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -15),
            toDownArrowImageView.heightAnchor.constraint(equalToConstant: 15),
            toDownArrowImageView.widthAnchor.constraint(equalToConstant: 20),
            toDownArrowImageView.centerYAnchor.constraint(equalTo: toView.centerYAnchor),
            getExchangeRateButton.leadingAnchor.constraint(equalTo: fromView.leadingAnchor),
            getExchangeRateButton.trailingAnchor.constraint(equalTo: toView.trailingAnchor),
            getExchangeRateButton.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: 30),
            getExchangeRateButton.heightAnchor.constraint(equalToConstant: 40),
            exchangeRateView.leadingAnchor.constraint(equalTo: getExchangeRateButton.leadingAnchor),
            exchangeRateView.trailingAnchor.constraint(equalTo: getExchangeRateButton.trailingAnchor),
            exchangeRateView.topAnchor.constraint(equalTo: getExchangeRateButton.bottomAnchor, constant: 30),
            exchangeRateView.heightAnchor.constraint(equalToConstant: 80),
            exchangeRateLabel.centerYAnchor.constraint(equalTo: exchangeRateView.centerYAnchor),
            exchangeRateLabel.centerXAnchor.constraint(equalTo: exchangeRateView.centerXAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timeSeriesErrorLabel.topAnchor.constraint(equalTo: exchangeRateView.bottomAnchor, constant: 10),
            timeSeriesErrorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeSeriesErrorLabel.leadingAnchor.constraint(equalTo: exchangeRateView.leadingAnchor),
            timeSeriesErrorLabel.trailingAnchor.constraint(equalTo: exchangeRateView.trailingAnchor),
        ])
    }
}

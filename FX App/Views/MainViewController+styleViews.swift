//
//  MainViewController+styleViews.swift
//  FX App
//
//  Created by Kuda Zata on 4/5/2023.
//

import Foundation
import UIKit

extension MainViewController {
    
    ///This function is responsible for styling all the views in the ViewController
    func styleViews() {
        
        /// setting the background color
        view.backgroundColor = .white
        
        /// styling for titleLabel
        titleLabel.font = UIFont(name: "Avenir-black", size: 20)
        
        /// styling for From and To labels
        fromLabel.font = UIFont(name: "Avenir-medium", size: 11)
        toLabel.font = UIFont(name: "Avenir-medium", size: 11)
        
        /// styling for fromCurrencyLabel and toCurrencyLabel
        fromCurrencyLabel.font = UIFont(name: "Avenir-heavy", size: 15)
        toCurrencyLabel.font = UIFont(name: "Avenir-heavy", size: 15)
        
        /// styling for fromView
        fromView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.05)
        fromView.layer.borderColor = UIColor.systemPink.cgColor
        fromView.layer.borderWidth = 0.1
        fromView.layer.cornerRadius = 5
        
        /// styling for toView
        toView.backgroundColor = .systemPink.withAlphaComponent(0.05)
        toView.layer.borderColor = UIColor.systemPink.cgColor
        toView.layer.borderWidth = 0.1
        toView.layer.cornerRadius = 5
        
        /// styling for toDownArrowImageView and fromDownArrowImageView
        toDownArrowImageView.tintColor = .darkGray
        fromDownArrowImageView.tintColor = .darkGray
        
        /// styling for getExchangeRate button
        getExchangeRateButton.backgroundColor = .systemPink
        getExchangeRateButton.setTitleColor(.white, for: .normal)
        getExchangeRateButton.titleLabel?.font = UIFont(name: "Avenir-black", size: 14)
        getExchangeRateButton.layer.cornerRadius = 5
        
        /// styling for exchangeRateLabel
        exchangeRateLabel.font = UIFont(name: "Avenir-black", size: 20)
        exchangeRateLabel.textColor = .darkGray
        
        /// styling for timeSeriesError label
        timeSeriesErrorLabel.font = UIFont(name: "Avenir-medium", size: 12)
        timeSeriesErrorLabel.textColor = .lightGray
        timeSeriesErrorLabel.numberOfLines = 0
        timeSeriesErrorLabel.isHidden = true
        
        /// styling for exchangeRateView
        exchangeRateView.layer.cornerRadius = 5
        exchangeRateView.backgroundColor = .systemPink.withAlphaComponent(0.05)
        exchangeRateView.layer.borderColor = UIColor.systemPink.cgColor
        exchangeRateView.layer.borderWidth = 0.1
        
        /// styling for activityIndiciator
        activityIndicator.style = .large
        activityIndicator.color = .systemPink
    }
}

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
        
        view.backgroundColor = .white
        titleLabel.font = UIFont(name: "Avenir-black", size: 20)
        fromLabel.font = UIFont(name: "Avenir-medium", size: 11)
        toLabel.font = UIFont(name: "Avenir-medium", size: 11)
        
        fromCurrencyLabel.font = UIFont(name: "Avenir-heavy", size: 15)
        toCurrencyLabel.font = UIFont(name: "Avenir-heavy", size: 15)
        
        fromView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.05)
        fromView.layer.borderColor = UIColor.systemPink.cgColor
        fromView.layer.borderWidth = 0.1
        fromView.layer.cornerRadius = 5
        
        toView.backgroundColor = .systemPink.withAlphaComponent(0.05)
        toView.layer.borderColor = UIColor.systemPink.cgColor
        toView.layer.borderWidth = 0.1
        toView.layer.cornerRadius = 5
        
        toDownArrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        toDownArrowImageView.tintColor = .darkGray
        fromDownArrowImageView.tintColor = .darkGray
        
        getExchangeRateButton.backgroundColor = .systemPink
        getExchangeRateButton.setTitleColor(.white, for: .normal)
        getExchangeRateButton.titleLabel?.font = UIFont(name: "Avenir-black", size: 14)
        getExchangeRateButton.layer.cornerRadius = 5
        
        exchangeRateLabel.font = UIFont(name: "Avenir-black", size: 20)
        exchangeRateLabel.textColor = .darkGray
        
        timeSeriesErrorLabel.font = UIFont(name: "Avenir-medium", size: 12)
        timeSeriesErrorLabel.textColor = .lightGray
        timeSeriesErrorLabel.numberOfLines = 0
        timeSeriesErrorLabel.isHidden = true
        
        exchangeRateView.layer.cornerRadius = 5
        exchangeRateView.backgroundColor = .systemPink.withAlphaComponent(0.05)
        exchangeRateView.layer.borderColor = UIColor.systemPink.cgColor
        exchangeRateView.layer.borderWidth = 0.1
        
        activityIndicator.style = .large
        activityIndicator.color = .systemPink
    }
}

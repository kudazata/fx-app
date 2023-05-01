//
//  MainViewController.swift
//  FX App
//
//  Created by Kuda Zata on 2/5/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let titleLabel = UILabel()
    let fromLabel = UILabel()
    let toLabel = UILabel()
    let fromView = UIView()
    let toView = UIView()
    let fromDownArrowImageView = UIImageView()
    let toDownArrowImageView = UIImageView()
    let fromCurrencyLabel = UILabel()
    let toCurrencyLabel = UILabel()
    let getExchangeRateButton = UIButton()
    let exchangeRateView = UIView()
    let exchangeRateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    /// This function is responsible for rendering the UI elements in this view controller. All elements are intialized programmatically
    private func setupViews() {
        
        view.addSubview(titleLabel)
        view.addSubview(fromLabel)
        view.addSubview(toLabel)
        view.addSubview(fromView)
        view.addSubview(toView)
        view.addSubview(getExchangeRateButton)
        view.addSubview(exchangeRateView)
        fromView.addSubview(fromDownArrowImageView)
        fromView.addSubview(fromCurrencyLabel)
        toView.addSubview(toDownArrowImageView)
        toView.addSubview(toCurrencyLabel)
        exchangeRateView.addSubview(exchangeRateLabel)
        
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
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
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
            exchangeRateLabel.centerXAnchor.constraint(equalTo: exchangeRateView.centerXAnchor)
            
        ])
        
        view.backgroundColor = .white
        
        titleLabel.text = "FX Currency Converter"
        titleLabel.font = UIFont(name: "Avenir-black", size: 20)
        
        fromLabel.text = "From"
        fromLabel.font = UIFont(name: "Avenir-medium", size: 11)
        
        toLabel.text = "To"
        toLabel.font = UIFont(name: "Avenir-medium", size: 11)
        
        fromCurrencyLabel.text = "USD"
        fromCurrencyLabel.font = UIFont(name: "Avenir-heavy", size: 15)
        
        toCurrencyLabel.text = "ZAR"
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
        
        fromDownArrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        fromDownArrowImageView.tintColor = .darkGray
        
        getExchangeRateButton.backgroundColor = .systemPink
        getExchangeRateButton.setTitle("Get Exchange rate", for: .normal)
        getExchangeRateButton.setTitleColor(.white, for: .normal)
        getExchangeRateButton.titleLabel?.font = UIFont(name: "Avenir-black", size: 14)
        getExchangeRateButton.layer.cornerRadius = 5
        
        exchangeRateLabel.text = "1 USD = 18.99 ZAR"
        exchangeRateLabel.font = UIFont(name: "Avenir-black", size: 20)
        exchangeRateLabel.textColor = .darkGray
        
        exchangeRateView.layer.cornerRadius = 5
        exchangeRateView.backgroundColor = .systemPink.withAlphaComponent(0.05)
        exchangeRateView.layer.borderColor = UIColor.systemPink.cgColor
        exchangeRateView.layer.borderWidth = 0.1

    }

}

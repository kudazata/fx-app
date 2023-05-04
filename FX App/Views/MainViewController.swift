//
//  MainViewController.swift
//  FX App
//
//  Created by Kuda Zata on 2/5/2023.
//

import UIKit
import SwiftUI
import Combine
import DropDown

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
    let activityIndicator = UIActivityIndicatorView()
    let timeSeriesErrorLabel = UILabel()
    var graphView = UIView()
    let fromCurrenciesDropDown = DropDown()
    let toCurrenciesDropDown = DropDown()
    let mainViewModel = MainViewModel()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        styleViews()
        setupConstraints()
        bindViewModel()
        mainViewModel.getCurrencies()
    }
    
    
    //MARK: - Setting up views
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
        view.addSubview(activityIndicator)
        view.addSubview(timeSeriesErrorLabel)
        
        titleLabel.text = "FX Currency Converter"
        fromLabel.text = "From"
        toLabel.text = "To"
        fromCurrencyLabel.text = "USD"
        toCurrencyLabel.text = "ZAR"
        
        fromView.isUserInteractionEnabled = true
        let fromViewTappedGesture = UITapGestureRecognizer(target: self, action:  #selector (self.fromViewTapped(_:)))
        fromView.addGestureRecognizer(fromViewTappedGesture)
        
        toView.isUserInteractionEnabled = true
        let toViewTappedGesture = UITapGestureRecognizer(target: self, action:  #selector (self.toViewTapped(_:)))
        toView.addGestureRecognizer(toViewTappedGesture)
        
        fromDownArrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        
        getExchangeRateButton.setTitle("Get Exchange rate", for: .normal)
        getExchangeRateButton.addTarget(self, action: #selector(getExchangeRateTapped), for: .touchUpInside)
        
        exchangeRateView.isHidden = true
        
    }
    
    ///This function is responsible for setting up the graph. It will only be called if the backend returns time series information for a particular exchange rate
    func setupGraphView(timeSeriesArray: [TimeSeriesPoint]) {
        
        let controller = UIHostingController(rootView: GraphView(timeSeriesArray: timeSeriesArray))
        
        if let graph = controller.view {
            self.graphView = graph
            view.addSubview(graphView)
            graphView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                graphView.topAnchor.constraint(equalTo: exchangeRateView.bottomAnchor, constant: 30),
                graphView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -30),
                graphView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                graphView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
                
            ])
        }
    }
    
    ///This function is responsible for setting up the currency picker dropdowns using DropDown library
    func setupDropDowns(currencies: [String]) {
        
        fromCurrenciesDropDown.anchorView = fromView
        toCurrenciesDropDown.anchorView = toView
        
        fromCurrenciesDropDown.dataSource = currencies
        toCurrenciesDropDown.dataSource = currencies
        
        fromCurrenciesDropDown.selectionAction  = { [unowned self] (index: Int, item: String) in
            fromCurrencyLabel.text = mainViewModel.currencyCodesArray[index]
            
        }
        
        toCurrenciesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            toCurrencyLabel.text = mainViewModel.currencyCodesArray[index]
        }
        
        fromCurrencyLabel.text = mainViewModel.currencyCodesArray[0]
        toCurrencyLabel.text = mainViewModel.currencyCodesArray[1]
    }
    
    
    
    //MARK: - Button action functions
    
    @objc func fromViewTapped(_ sender:UITapGestureRecognizer) {
        fromCurrenciesDropDown.show()
    }
    
    @objc func toViewTapped(_ sender:UITapGestureRecognizer) {
        toCurrenciesDropDown.show()
    }
    
    @objc func getExchangeRateTapped(_ sender: UIButton) {
        graphView.removeFromSuperview()
        exchangeRateView.isHidden = true
        timeSeriesErrorLabel.isHidden = true
        mainViewModel.getExchangeRateAndTimeSeries(from: fromCurrencyLabel.text!, to: toCurrencyLabel.text!)
    }
    
}

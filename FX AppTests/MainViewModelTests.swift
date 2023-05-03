//
//  MainViewModelTests.swift
//  FX AppTests
//
//  Created by Kuda Zata on 2/5/2023.
//

import XCTest
import Combine
@testable import FX_App

class MainViewModelTests: XCTestCase {
    
    var mainViewModel: MainViewModel!
    var networkServiceMock = NetworkServiceMock()
    var errorMessage = ""
    var exchangeRate: ExchangeRate!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        mainViewModel = MainViewModel(networkService: networkServiceMock)
        mainViewModel.networkError.sink { [weak self] errorMessage in
            self?.errorMessage = errorMessage
        }.store(in: &cancellables)
    }

    override func tearDownWithError() throws {
        mainViewModel = nil
        errorMessage = ""
        exchangeRate = nil
    }
    
    func testCurrencyArraysCount_ShouldInitiallyBeZero() {
        XCTAssertEqual(mainViewModel.currencyNamesArray.count, 0)
        XCTAssertEqual(mainViewModel.currencyCodesArray.count, 0)
    }
    
    func testPopulationOfCurrencyArrays_ShouldHaveEqualCounts() {
        mainViewModel.getCurrencies()
        XCTAssertEqual(mainViewModel.currencyNamesArray.count, mainViewModel.currencyCodesArray.count)
    }

    func testGetCurrencies_ShouldPopulateCurrencyArrays() {
        mainViewModel.getCurrencies()
        XCTAssertTrue(mainViewModel.currencyNamesArray.count > 0)
        XCTAssertTrue(mainViewModel.currencyCodesArray.count > 0)
        XCTAssertEqual(mainViewModel.currencyNamesArray[0], "Argentine Peso")
        XCTAssertEqual(mainViewModel.currencyCodesArray[0], "ARS")
    }

    func testGetCurrenciesError_ShouldPopulateCorrectErrorMessage() {
        networkServiceMock.shouldFail = true
        mainViewModel.networkService = networkServiceMock
        mainViewModel.getCurrencies()
        XCTAssertEqual(self.errorMessage, "There was no data returned from the server")
    }
    
    func testGetExchangeRate_ShouldReturnExchangeRateObject() {
        mainViewModel.exchangeRate.sink { [weak self] exchangeRate in
            self?.exchangeRate = exchangeRate
        }.store(in: &cancellables)
        mainViewModel.getExchangeRate(from: "USD", to: "ZAR")
        XCTAssertEqual(self.exchangeRate.to, "ZAR")
        XCTAssertEqual(self.exchangeRate.from, "USD")
        XCTAssertEqual(self.exchangeRate.total, 18.55)
    }
    
    func testGetExchangeRateError_ShouldPopulateCorrectErrorMessage() {
        networkServiceMock.shouldFail = true
        mainViewModel.networkService = networkServiceMock
        mainViewModel.getExchangeRate(from: "USD", to: "ZAR")
        XCTAssertEqual(self.errorMessage, "There was no data returned from the server")
    }

}

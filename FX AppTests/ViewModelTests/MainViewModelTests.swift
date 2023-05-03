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
    
    var sut: MainViewModel!
    var networkServiceMock = NetworkServiceMock()
    var exchangeRate: ExchangeRate!
    var timeSeriesArray: [TimeSeriesPoint]!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        sut = MainViewModel(networkService: networkServiceMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        exchangeRate = nil
        timeSeriesArray = nil
    }
    
    func testCurrencyArraysCount_ShouldInitiallyBeZero() {
        XCTAssertEqual(sut.currencyNamesArray.count, 0)
        XCTAssertEqual(sut.currencyCodesArray.count, 0)
    }
    
    func testPopulationOfCurrencyArrays_ShouldHaveEqualCounts() {
        sut.getCurrencies()
        XCTAssertEqual(sut.currencyNamesArray.count, sut.currencyCodesArray.count)
    }

    func testGetCurrencies_ShouldPopulateCurrencyArrays() {
        sut.getCurrencies()
        XCTAssertTrue(sut.currencyNamesArray.count > 0)
        XCTAssertTrue(sut.currencyCodesArray.count > 0)
        XCTAssertEqual(sut.currencyNamesArray[0], "Argentine Peso")
        XCTAssertEqual(sut.currencyCodesArray[0], "ARS")
    }

    func testGetCurrenciesError_ShouldPopulateCorrectErrorMessage() {
        networkServiceMock.shouldFail = true
        sut.networkService = networkServiceMock
        sut.getCurrencies()
        XCTAssertEqual(sut.networkError?.message, "There was no data returned from the server")
    }
    
    func testGetExchangeRate_ShouldReturnExchangeRateObject() {
        sut.getExchangeRate(from: "USD", to: "ZAR")
        XCTAssertEqual(sut.exchangeRate!.to, "ZAR")
        XCTAssertEqual(sut.exchangeRate!.from, "USD")
        XCTAssertEqual(sut.exchangeRate!.total, 18.55)
    }
    
    func testGetExchangeRateError_ShouldPopulateCorrectErrorMessage() {
        networkServiceMock.shouldFail = true
        sut.networkService = networkServiceMock
        sut.getExchangeRate(from: "USD", to: "ZAR")
        XCTAssertEqual(sut.networkError?.message, "There was no data returned from the server")
    }
    
    func testGetTimeSeries_ShouldPopulateTimeSeriesArray() {
        sut.getTimeSeries(from: "USD", to: "ZAR")
        XCTAssertNotNil(sut.timeSeriesArray!)
        XCTAssertEqual(sut.timeSeriesArray![0].exchangeRate, 17.8495)
        XCTAssertEqual(sut.timeSeriesArray![22].exchangeRate, 18.29788)
    }
    
    func testGetTimeSeriesError_ShouldPopulateCorrectErrorMessage() {
        networkServiceMock.shouldFail = true
        sut.networkService = networkServiceMock
        sut.getTimeSeries(from: "USD", to: "ZAR")
        XCTAssertEqual(sut.networkError?.message, "The request that was sent is invalid")
    }
    
    func testGetExchangeRateAndTimeSeries_ShouldPopulateExchangeRateAndTimeSeriesArray() {
        sut.getExchangeRateAndTimeSeries(from: "USD", to: "ZAR")
        XCTAssertNotNil(sut.timeSeriesArray)
        XCTAssertNotNil(sut.exchangeRate)
        XCTAssertEqual(sut.timeSeriesArray?[0].exchangeRate, 17.8495)
        XCTAssertEqual(sut.timeSeriesArray?[22].exchangeRate, 18.29788)
        XCTAssertEqual(sut.exchangeRate?.price, 18.55)
    }
    
    func testGetExchangeRateAndTimeSeriesError_ShouldPopulateCorrectErrorMessage() {
        networkServiceMock.shouldFail = true
        sut.networkService = networkServiceMock
        sut.getExchangeRateAndTimeSeries(from: "USD", to: "ZAR")
        XCTAssertEqual(sut.networkError?.message, "The request that was sent is invalid")
    }

}

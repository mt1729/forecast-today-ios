//
//  ForecastTodayTests.swift
//  ForecastTodayTests
//
//  Created by Matthew Taylor on 3/18/22.
//
//

import XCTest
import Combine
@testable import ForecastToday

class ForecastTodayTests: XCTestCase {
    private var disposeBag: Set<AnyCancellable>!

    override func setUpWithError() throws {
        disposeBag = []
    }

    override func tearDownWithError() throws {
        disposeBag.forEach { $0.cancel() }
    }

     func testValidZip() throws {
         // Given
         struct ValidZipRestAPI: RestAPI {
             private let mockForecastRes = ForecastResponse.fromJSON(fileName: "forecastResponse")!

             func fetchHourlyForecast(_ reqBody: ForecastRequest) -> Future<NetworkResult<ForecastResponse>, Never> {
                 Future<NetworkResult<ForecastResponse>, Never> { promise in
                     promise(.success(.success(200, mockForecastRes)))
                 }
             }
         }
         let restAPI = ValidZipRestAPI()
         let weatherRepo = WeatherRepository(bkgQueue: DispatchQueue.global(), restApi: restAPI)
         let homeVM = HomeVM(bkgQueue: DispatchQueue.global(), repo: weatherRepo)

         // When
         homeVM.zipCode = "90210"

         // Then
         let expectForecast = expectation(description: "forecast")
         homeVM.$forecast.receive(on: DispatchQueue.main)
             .sink {
                 if $0 != nil {
                     expectForecast.fulfill()
                 }
             }
             .store(in: &disposeBag)
         waitForExpectations(timeout: 5)

         XCTAssertEqual(homeVM.listMsg, "")
         XCTAssertGreaterThan(homeVM.todayForecastHours.count, 0)
     }

     func testInvalidZip() throws {
         // Given
         struct InvalidValidZipRestAPI: RestAPI {
             func fetchHourlyForecast(_ reqBody: ForecastRequest) -> Future<NetworkResult<ForecastResponse>, Never> {
                 Future<NetworkResult<ForecastResponse>, Never> { promise in
                     promise(.success(.failure(400)))
                 }
             }
         }
         let restAPI = InvalidValidZipRestAPI()
         let weatherRepo = WeatherRepository(bkgQueue: DispatchQueue.global(), restApi: restAPI)
         let homeVM = HomeVM(bkgQueue: DispatchQueue.global(), repo: weatherRepo)

         // When
         homeVM.zipCode = "00000"

         // Then
         let expectListMsg = expectation(description: "listMsg")
         homeVM.$listMsg.receive(on: DispatchQueue.main)
             .sink {
                 if $0 == HomeVM.genericErrMsg {
                     expectListMsg.fulfill()
                 }
             }
             .store(in: &disposeBag)
         waitForExpectations(timeout: 5)

         XCTAssertEqual(homeVM.listMsg, HomeVM.genericErrMsg)
         XCTAssertEqual(homeVM.todayForecastHours.count, 0)
     }
}

//
// Created by Matthew Taylor on 3/20/22.
//

import UIKit
import Combine
import Foundation

// Keep as a protocol to use for custom mocks during unit tests or other swappable implementations
protocol RestAPI {
    func fetchHourlyForecast(_ hourlyForecastBody: ForecastRequest) -> Future<NetworkResult<ForecastResponse>, Never>
    func fetchConditionImage(imgUri: String) -> Future<NetworkResult<UIImage>, Never>
}

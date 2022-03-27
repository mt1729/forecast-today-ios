//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

struct ForecastResponse: Codable {
    let current: CurrentForecast
    let forecast: Forecast
    let location: ForecastLocation
}

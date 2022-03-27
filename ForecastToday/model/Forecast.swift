//
// Created by Matthew Taylor on 3/27/22.
//

import Foundation

struct Forecast: Codable {
    let daysInfo: [ForecastDayInfo]

    // TODO: - Custom `CodingKey` property wrapper to cut down boilerplate?
    enum CodingKeys: String, CodingKey {
        case daysInfo = "forecastday"
    }
}

//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

struct ForecastResponse: Codable {
    let current: CurrentForecast
    let forecast: Forecast
    let location: ForecastLocation

    static func fromJSON(fileName: String) -> ForecastResponse? {
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: ".json"),
            let data = try? Data(contentsOf: url),
            let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data) else {
            return nil
        }
        return forecastResponse
    }
}

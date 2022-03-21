//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

// TODO: - Swinject singleton
class WeatherRepository {
    let api: RestAPI
    init (restAPI api: RestAPI) {
        self.api = api
        hourlyForecast = NetworkResult.pending
    }

    @Published private(set) var hourlyForecast: NetworkResult<Forecast>

    func fetchHourlyForecast(zipCode: String) -> NetworkResult<Forecast> {
        hourlyForecast = NetworkResult.pending
        do {
            let reqBody = HourlyForecastBody(zipCode)

            // let res = try await api.fetchHourlyForecast(reqBody)
            // TODO: - Declare publisher as `success`
        } catch {
            hourlyForecast = NetworkResult.error(error)
        }
        return hourlyForecast
    }
}

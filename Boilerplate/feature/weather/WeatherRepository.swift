//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

// TODO: - Swinject singleton
class WeatherRepository {
    let api: RestAPI
    let queue: DispatchQueue
    init (dispatchQueue queue: DispatchQueue, restAPI api: RestAPI) {
        self.api = api
        self.queue = queue

        hourlyForecast = NetworkResult.empty
    }

    private var disposeBag = Set<AnyCancellable>()
    @Published private(set) var hourlyForecast: NetworkResult<Forecast>

    func fetchHourlyForecast(zipCode: String) -> NetworkResult<Forecast> {
        hourlyForecast = NetworkResult.pending

        let reqBody = ForecastRequest(zipCode)
        api.fetchHourlyForecast(reqBody)
                .receive(on: queue)
                .sink {
                    self.hourlyForecast = $0
                }
                .store(in: &disposeBag)

        return hourlyForecast
    }
}

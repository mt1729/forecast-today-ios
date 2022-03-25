//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

class WeatherRepository: ObservableObject {
    let api: RestAPI
    let queue: DispatchQueue
    init (dispatchQueue queue: DispatchQueue, restAPI api: RestAPI) {
        self.api = api
        self.queue = queue

        todayForecastRes = NetworkResult.empty
    }

    private var disposeBag = Set<AnyCancellable>()
    @Published private(set) var todayForecastRes: NetworkResult<ForecastResponse>

    func fetchTodayForecast(zipCode: String) {
        todayForecastRes = NetworkResult.pending

        let reqBody = ForecastRequest(zipCode)
        api.fetchHourlyForecast(reqBody)
                .receive(on: queue)
                .sink { self.todayForecastRes = $0 }
                .store(in: &disposeBag)
    }
}

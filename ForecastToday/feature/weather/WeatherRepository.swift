//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

class WeatherRepository: ObservableObject {
    let restApi: RestAPI
    let bkgQueue: DispatchQueue

    private var disposeBag = Set<AnyCancellable>()
    @Published private(set) var todayForecastRes: NetworkResult<ForecastResponse>

    init (bkgQueue: DispatchQueue, restApi: RestAPI) {
        self.restApi = restApi
        self.bkgQueue = bkgQueue

        todayForecastRes = NetworkResult.empty
    }

    func fetchTodayForecast(zipCode: String) {
        todayForecastRes = NetworkResult.pending

        let reqBody = ForecastRequest(zipCode)
        restApi.fetchHourlyForecast(reqBody)
                .receive(on: bkgQueue)
                .sink { self.todayForecastRes = $0 }
                .store(in: &disposeBag)
    }
}

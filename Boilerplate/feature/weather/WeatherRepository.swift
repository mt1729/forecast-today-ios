//
// Created by Matthew Taylor on 3/20/22.
//

import UIKit
import Combine
import Foundation

class WeatherRepository: ObservableObject {
    let api: RestAPI
    let queue: DispatchQueue

    // TODO: - Using NSCache for images should be more memory efficient
    private var disposeBag = Set<AnyCancellable>()
    @Published private(set) var conditionImages: [String: UIImage]
    @Published private(set) var todayForecastRes: NetworkResult<ForecastResponse>

    init (dispatchQueue queue: DispatchQueue, restAPI api: RestAPI) {
        self.api = api
        self.queue = queue

        conditionImages = [:]
        todayForecastRes = NetworkResult.empty
    }

    func fetchTodayForecast(zipCode: String) {
        todayForecastRes = NetworkResult.pending

        let reqBody = ForecastRequest(zipCode)
        api.fetchHourlyForecast(reqBody).receive(on: queue)
                .sink {
                    self.todayForecastRes = $0
                    if case let .success(_, res) = $0 {
                        res.forecast.forecastday.first?.hour.forEach {
                            self.fetchConditionImage(imgUri: $0.condition.iconURI)
                        }
                    }
                }
                .store(in: &disposeBag)
    }

    private func fetchConditionImage(imgUri: String) {
        if conditionImages[imgUri] != nil {
            print("cache hit")
            return
        }

        print("cache miss")
        api.fetchConditionImage(imgUri: imgUri).receive(on: DispatchQueue.main)
                .sink {
                    switch $0 {
                    case let .success(_, img):
                        self.conditionImages[imgUri] = img
                    default:
                        break
                    }
                }
                .store(in: &disposeBag)
    }
}

//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

class HomeVM {
    let repo: WeatherRepository
    init(weatherRepository repo: WeatherRepository) {
        self.repo = repo

        forecast = nil
        _ = repo.fetchHourlyForecast(zipCode: "90210")
    }

    @Published private(set) var forecast: Forecast?
}

//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

// TODO: - Prompt for location permission to auto-fetch user zip
class HomeVM {
    private static let defaultZip = "95014" // Apple HQ
    private static let debounceMs = 500
    private static let genericErrMsg = "Hmm, it looks like something went wrong on our end. Please try again later"

    let repo: WeatherRepository
    let queue: DispatchQueue

    init(dispatchQueue queue: DispatchQueue, weatherRepository repo: WeatherRepository) {
        self.repo = repo
        self.queue = queue

        // Default/init VM state
        zipCode = HomeVM.defaultZip
        isLoading = false

        // (Intensive) calculations from input should be done outside main queue
        $zipCode.receive(on: queue)
                .debounce(for: .milliseconds(500), scheduler: queue)
                // Quick check if input is digits only
                .filter { $0.count == 5 && Int($0) != nil }
                .sink { repo.fetchTodayForecast(zipCode: $0) }
                .store(in: &disposeBag)

        // Each subscriber below is intended to be organized per publisher within this view model
        // It might not be line-length ideal, though maintainability may be more ideal

        repo.$todayForecastRes.receive(on: DispatchQueue.main)
                .sink {
                    // TODO: - There might be a more syntactically concise alternative
                    switch $0 {
                    case .pending:
                        self.isLoading = true
                    default:
                        self.isLoading = false
                    }
                }
                .store(in: &disposeBag)

        repo.$todayForecastRes.receive(on: DispatchQueue.main)
                .sink { todayForecast in
                    switch todayForecast {
                    case .pending:
                        self.forecast = nil
                    case let .success(_, forecastRes):
                        self.forecast = forecastRes.forecast
                    default:
                        break
                    }
                }
                .store(in: &disposeBag)

        repo.$todayForecastRes.receive(on: DispatchQueue.main)
                .sink { todayForecast in
                    switch todayForecast {
                    case .pending:
                        self.errorMsg = nil
                    case .failure, .error:
                        self.errorMsg = HomeVM.genericErrMsg
                    default:
                        break
                    }
                }
                .store(in: &disposeBag)
    }

    private var disposeBag = Set<AnyCancellable>()
    @Published private(set) var zipCode: String
    @Published private(set) var forecast: Forecast?
    @Published private(set) var errorMsg: String?
    @Published private(set) var isLoading: Bool
}

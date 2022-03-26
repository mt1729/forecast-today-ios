//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

class HomeVM: ObservableObject {
    private static let debounceMs = 500
    private static let genericErrMsg = "Hmm, it looks like something went wrong on our end. Please try again later"
    private static let emptyStateMsg = "Hourly forecast results will show up here with a valid zip code"

    let repo: WeatherRepository
    let bkgQueue: DispatchQueue

    private var disposeBag = Set<AnyCancellable>()
    @Published var zipCode: String
    @Published private(set) var listMsg: String
    @Published private(set) var forecast: Forecast?
    @Published private(set) var isLoading: Bool

    init(bkgQueue: DispatchQueue, repo: WeatherRepository) {
        self.repo = repo
        self.bkgQueue = bkgQueue

        // Default/init VM state
        zipCode = ""
        listMsg = ""
        isLoading = false

        // (Intensive) calculations from input should be done outside main queue
        $zipCode.receive(on: bkgQueue)
                .debounce(for: .milliseconds(500), scheduler: bkgQueue)
                // Quick check if input is digits only
                .filter { $0.count == 5 && Int($0) != nil }
                .sink { repo.fetchTodayForecast(zipCode: $0) }
                .store(in: &disposeBag)

        // Each subscriber below is intended to be organized per publisher within this view model
        // It might not be line-length ideal, though maintainability may be more ideal
        repo.$todayForecastRes.receive(on: DispatchQueue.main)
                .sink {
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
                    case .empty:
                        self.listMsg = HomeVM.emptyStateMsg
                    case .pending:
                        self.listMsg = ""
                    case .failure, .error:
                        self.listMsg = HomeVM.genericErrMsg
                    default:
                        break
                    }
                }
                .store(in: &disposeBag)
    }
}

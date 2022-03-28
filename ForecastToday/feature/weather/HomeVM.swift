//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

class HomeVM: ObservableObject {
    private static let debounceMs = 500
    static let genericErrMsg = "Hmm, it looks like something went wrong on our end. Please try again later"
    static let emptyStateMsg = "Hourly forecast results will show up here with a valid zip code"

    private let repo: WeatherRepository
    private let bkgQueue: DispatchQueue

    private var disposeBag = Set<AnyCancellable>()
    @Published var zipCode: String
    @Published private(set) var listMsg: String
    @Published private(set) var forecast: Forecast?
    @Published private(set) var isLoading: Bool
    @Published private(set) var todayForecastHours: [ForecastHour]

    init(bkgQueue: DispatchQueue, repo: WeatherRepository) {
        self.repo = repo
        self.bkgQueue = bkgQueue

        // Default/init VM state
        zipCode = ""
        listMsg = ""
        isLoading = false
        todayForecastHours = []

        subscribeZipCode(on: bkgQueue)

        // Any publishing needs to be done on main queue
        publishForecast(on: DispatchQueue.main)
        publishTodayForecastRes(on: DispatchQueue.main)
    }

    private func subscribeZipCode(on queue: DispatchQueue) {
        // (Intensive) calculations from input should be done outside main queue
        $zipCode.receive(on: queue)
            .debounce(for: .milliseconds(HomeVM.debounceMs), scheduler: queue)
            // Quick check if input is correct length and digits only
            .filter {
                $0.count == 5 && Int($0) != nil
            }
            .sink {
                self.repo.fetchTodayForecast(zipCode: $0)
            }
            .store(in: &disposeBag)
    }

    private func publishForecast(on queue: DispatchQueue) {
        $forecast.receive(on: queue)
            .sink {
                self.todayForecastHours = $0?.daysInfo.first?.hour ?? []
            }
            .store(in: &disposeBag)
    }

    private func publishTodayForecastRes(on queue: DispatchQueue) {
        // Each subscriber below is intended to be organized per published value within this view model
        // It may be more lengthy than normal, though maintainability is the focus
        repo.$todayForecastRes.receive(on: queue)
            .sink {
                switch $0 {
                case .pending:
                    self.isLoading = true
                default:
                    self.isLoading = false
                }
            }
            .store(in: &disposeBag)

        repo.$todayForecastRes.receive(on: queue)
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

        repo.$todayForecastRes.receive(on: queue)
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

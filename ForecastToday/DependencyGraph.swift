//
// Created by Matthew Taylor on 3/26/22.
//

import Foundation

// TODO: - Better to have a dependency resolver and break out into 'module' files per feature
// Keep as class to avoid `struct` pass-by-value / duplication semantics
class DependencyGraph {
    let restApi: RestAPI
    let bkgQueue: DispatchQueue

    // VM may be needed as local state instead of global. In that case, just use `@StateObject` in the view
    let homeVM: HomeVM
    let weatherRepo: WeatherRepository

    // Dependencies here are externally provided or mocked, and others are inferred by those
    init(bkgQueue: DispatchQueue, restApi: RestAPI) {
        self.restApi = restApi
        self.bkgQueue = bkgQueue

        weatherRepo = WeatherRepository(bkgQueue: bkgQueue, restApi: restApi)
        homeVM = HomeVM(bkgQueue: bkgQueue, repo: weatherRepo)
    }

    class func new() -> DependencyGraph {
        let bkgQueue = DispatchQueue.global()
        let urlSession = URLSession.shared
        let restApi = ForecastTodayRestAPI(urlSession: urlSession)
        return DependencyGraph(bkgQueue: bkgQueue, restApi: restApi)
    }
}

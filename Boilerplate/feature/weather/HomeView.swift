//
// Created by Matthew Taylor on 3/20/22.
//

import SwiftUI
import Foundation

struct HomeView: View {
    // TODO: - Form Swinject dependency graph
    init() {
        let api = BoilerplateRestAPI(urlSession: URLSession.shared)
        let repo = WeatherRepository(dispatchQueue: DispatchQueue.global(), restAPI: api)
        _ = HomeVM(weatherRepository: repo)
    }

    var body: some View {
        Text("HomeView")
    }
}

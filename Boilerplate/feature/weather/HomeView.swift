//
// Created by Matthew Taylor on 3/20/22.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @StateObject private var viewModel: HomeVM = {
        // TODO: - Use @EnvironmentObject to replace these lines and possibly Swinject?
        let queue = DispatchQueue.global()
        let api = BoilerplateRestAPI(urlSession: URLSession.shared)
        let repo = WeatherRepository(dispatchQueue: queue, restAPI: api)
        return HomeVM(dispatchQueue: queue, weatherRepository: repo)
    }()

    // TODO: - Localization / hardcoded strings
    var body: some View {
        VStack(alignment: .center) {
            TextField("Enter your zip code", text: $viewModel.zipCode)
                    .keyboardType(.decimalPad)
                    .padding()

            Spacer()

            // TODO: - Refactor content view / HStack to re-usable component
            // Alternatively, make a publisher inside VM with this mapping logic on `forecast`
            ZStack(alignment: .center) {
                List(viewModel.forecast?.forecastday.first?.hour ?? []) { forecastHour in
                    HStack {
                        // TODO: - Image()
                        Text("\(forecastHour.time)")
                        Spacer()
                        Text("\(forecastHour.tempF)&deg; F")
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text(viewModel.listMsg).padding()
                }
            }
        }.padding()
    }
}

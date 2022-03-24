//
// Created by Matthew Taylor on 3/20/22.
//

import SwiftUI
import Foundation

struct HomeView: View {
    // TODO: - Depending on app flow, this might want to be local state / StateObject instead of global state
    @EnvironmentObject private var viewModel: HomeVM

    // TODO: - Localization / hardcoded strings
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                TextField("Enter your zip code", text: $viewModel.zipCode)
                        .keyboardType(.decimalPad)
                        .padding()

                Spacer()

                // TODO: - Refactor content view / HStack to re-usable component
                // Alternatively, make a publisher inside VM with this accessor logic on `forecast`
                ZStack(alignment: .center) {
                    List(viewModel.forecast?.forecastday.first?.hour ?? []) { forecastHour in
                        NavigationLink(destination: ForecastDetailView(forecastHour: forecastHour)) {
                            HStack {
                                // TODO: - Image()
                                Text("\(forecastHour.time)")
                                Spacer()
                                Text("\(forecastHour.tempF)&deg; F")
                            }
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text(viewModel.listMsg).padding()
                    }
                }
            }.navigationTitle("Today's Forecast").padding()
        }
    }
}

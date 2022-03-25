//
// Created by Matthew Taylor on 3/20/22.
//

import SwiftUI
import Foundation

struct HomeView: View {
    // Depending on app flow, this might need to be local state / StateObject instead of global state
    @EnvironmentObject private var viewModel: HomeVM

    // TODO: - Localization / hardcoded strings
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                TextField("Enter your zip code", text: $viewModel.zipCode)
                        .keyboardType(.decimalPad)
                        .padding([.leading, .trailing, .top])

                Divider().background(Color.accentColor).padding([.horizontal, .bottom])

                ZStack(alignment: .center) {
                    List(viewModel.forecast?.forecastday.first?.hour ?? []) { hour in
                        ForecastHourRow(forecastHour: hour)
                    }
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text(viewModel.listMsg).padding(32).multilineTextAlignment(.center)
                    }
                }
            }.navigationTitle("Today's Forecast")
        }.navigationViewStyle(.stack)
    }
}

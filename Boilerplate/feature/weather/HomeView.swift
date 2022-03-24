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
                    List(viewModel.forecastHours) { hour in
                        NavigationLink(destination: ForecastDetailView(forecastHour: hour)) {
                            HStack {
                                if let img = viewModel.conditionImages[hour.condition.iconURI] {
                                    Image(uiImage: img).resizable().frame(width: 50, height: 50)
                                } else {
                                    ProgressView().frame(width: 50, height: 50)
                                }
                                Spacer()
                                Text("\(hour.time)")
                                Spacer()
                                Text("\(hour.tempF)&deg; F")
                            }.padding()
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

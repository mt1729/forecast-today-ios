//
// Created by Matthew Taylor on 3/20/22.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeVM

    // TODO: - Localization / hardcoded strings
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                TextField("Enter your zip code", text: $viewModel.zipCode)
                    .keyboardType(.decimalPad)
                    .padding([.leading, .trailing, .top])

                Divider()
                    .background(Color.accentColor)
                    .padding([.horizontal, .bottom])

                ZStack(alignment: .center) {
                    List(viewModel.forecast?.forecastday.first?.hour ?? []) { hour in
                        ForecastHourRow(forecastHour: hour)
                    }
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text(viewModel.listMsg)
                            .padding(32)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.gray)
                    }
                }
            }.navigationTitle("Today's Forecast")
        }.navigationViewStyle(.stack)
    }
}

class HomeView_Previews: PreviewProvider {
    static let deps = DependencyGraph.new()

    static var previews: some View {
        // To update preview with a state, mutate via VM functions
        HomeView().environmentObject(deps.homeVM)
    }

    // Needed for InjectionIII (AppCode)
    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: HomeView_Previews.previews)
    }
    #endif
}

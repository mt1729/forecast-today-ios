//
// Created by Matthew Taylor on 3/20/22.
//

import SwiftUI
import Foundation

struct ForecastDetailView: View {
    let forecastHour: Hour
    init(forecastHour: Hour) {
        self.forecastHour = forecastHour
    }

    var body: some View {
        NavigationView {
            Text("ForecastDetailView")
        }
    }
}

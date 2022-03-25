//
// Created by Matthew Taylor on 3/24/22.
//

import SwiftUI
import Foundation

struct ForecastHourRow: View {
    let forecastHour: Hour
    init(forecastHour: Hour) {
        self.forecastHour = forecastHour
    }

    var body: some View {
        NavigationLink(destination: ForecastDetailView(forecastHour: forecastHour)) {
            HStack {
                AsyncImage(
                        url: URL(string: "https:\(forecastHour.condition.iconURI)"),
                        content: { img in
                            img.resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                        },
                        placeholder: { ProgressView().frame(width: 50, height: 50) }
                )
                Text("\(forecastHour.time)")
                Spacer()
                Text("\(forecastHour.tempF)&deg; F")
            }
        }
    }
}

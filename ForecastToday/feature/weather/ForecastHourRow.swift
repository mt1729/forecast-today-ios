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
                Text("\(forecastHour.time.components(separatedBy: " ").last ?? "")")
                Spacer()
                Text("\(forecastHour.tempF.choppedZeroesString())&deg; F")
            }
        }
    }
}

class ForecastHourRow_Previews: PreviewProvider {
    // TODO: - Organize mock(s)
    static let mockForecastHour = Hour(timeEpoch: 1647748800, time: "2022-03-20 00:00",
            tempC: 9.4, tempF: 48.9, isDay: 0,
            condition: Condition(text: "Clear",
                    iconURI: "//cdn.weatherapi.com/weather/64x64/night/113.png\"", code: 1000
            ), windMph: 9.4, windKph: 15.1, windDegree: 333, windDir: "NNW",
            pressureMB: 1021.0, pressureIn: 30.16, precipMm: 0.0, precipIn: 0.0, humidity: 70, cloud: 22,
            feelslikeC: 7.2, feelslikeF: 45.0, windchillC: 7.2, windchillF: 45.0, heatindexC: 9.4, heatindexF: 48.9,
            dewpointC: 4.1, dewpointF: 39.4, willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0,
            visKM: 10.0, visMiles: 6.0, gustMph: 15.4, gustKph: 24.8, uv: 1.0)

    static var previews: some View {
        // To update preview with a state, mutate via VM functions
        ForecastHourRow(forecastHour: mockForecastHour)
    }

    // Needed for InjectionIII (AppCode)
    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ForecastHourRow_Previews.previews)
    }
    #endif
}

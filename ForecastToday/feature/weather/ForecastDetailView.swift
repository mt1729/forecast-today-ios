//
// Created by Matthew Taylor on 3/20/22.
//

import SwiftUI
import Foundation

struct ForecastDetailView: View {
    let forecastHour: ForecastHour

    init(forecastHour: ForecastHour) {
        self.forecastHour = forecastHour
    }

    var body: some View {
        VStack {
            Text(forecastHour.time.components(separatedBy: " ").last ?? "")
                .font(.title2)
                .padding(.bottom)
                .multilineTextAlignment(.center)

            AsyncImage(
                url: URL(string: "https:\(forecastHour.condition.iconURI)"),
                content: { img in
                    img.resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                },
                placeholder: { ProgressView().frame(width: 100, height: 100) }
            )

            Text("\(forecastHour.tempF.choppedZeroesString())&deg; F")
                .font(.title2)
                .padding(.bottom)
                .multilineTextAlignment(.center)

            ScrollView {
                VStack(alignment: .leading) {
                    Text("Temperature")
                        .font(.headline)
                        .padding(.bottom)
                    Text("Actual: \(forecastHour.tempF.choppedZeroesString())&deg; F")
                    Text("Feels Like: \(forecastHour.feelslikeF.choppedZeroesString())&deg; F")
                }
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading) {
                    Text("Wind").font(.headline).padding(.bottom)
                    Text("MPH: \(forecastHour.windMph.choppedZeroesString()) mph")
                    Text("Gust: \(forecastHour.gustMph.choppedZeroesString()) mph")
                    Text("Chill: \(forecastHour.windchillF.choppedZeroesString())&deg; F")
                    Text("Degree: \(forecastHour.windDegree)&deg;")
                    Text("Direction: \(forecastHour.windDir)")
                }
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading) {
                    Text("Precipitation").font(.headline).padding(.bottom)
                    Text("Pressure: \(forecastHour.pressureIn.choppedZeroesString()) mbar")
                    Text("Visibility: \(forecastHour.visMiles.choppedZeroesString()) miles")
                    Text("Chance of Rain: \(forecastHour.chanceOfRain)%")
                    Text("Chance of Snow: \(forecastHour.chanceOfSnow)%")
                }
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
                .padding([.top, .leading, .trailing])
        }
    }
}

class ForecastDetailView_Previews: PreviewProvider {
    static let mockForecastHour = ForecastResponse.fromJSON(fileName: "forecastResponse")!
        .forecast.daysInfo.first!.hour.first!

    static var previews: some View {
        ForecastDetailView(forecastHour: mockForecastHour)
    }

    // Needed for InjectionIII (AppCode)
    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
            UIHostingController(rootView: ForecastDetailView_Previews.previews)
    }
    #endif
}

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
        VStack {
            Text("\(forecastHour.time)").font(.title2).multilineTextAlignment(.center).padding(.bottom)

            AsyncImage(
                    url: URL(string: "https:\(forecastHour.condition.iconURI)"),
                    content: { img in
                        img.resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                    },
                    placeholder: { ProgressView().frame(width: 100, height: 100) }
            )

            Text("\(forecastHour.tempF)&deg; F").font(.title2).multilineTextAlignment(.center).padding(.bottom)

            ScrollView {
                VStack(alignment: .leading) {
                    Text("Temperature").font(.headline).padding(.bottom)
                    Text("Actual: \(forecastHour.tempF)&deg; F")
                    Text("Feels Like: \(forecastHour.feelslikeF)&deg; F")
                }.padding(.bottom).frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading) {
                    Text("Wind").font(.headline).padding(.bottom)
                    Text("MPH: \(forecastHour.windMph) mph")
                    Text("Gust: \(forecastHour.gustMph) mph")
                    Text("Chill: \(forecastHour.windchillF)&deg; F")
                    Text("Degree: \(forecastHour.windDegree)&deg;")
                    Text("Direction: \(forecastHour.windDir)")
                }.padding(.bottom).frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading) {
                    Text("Precipitation").font(.headline).padding(.bottom)
                    Text("Pressure: \(forecastHour.pressureIn) mbar")
                    Text("Visibility: \(forecastHour.visMiles) miles")
                    Text("Chance of Rain: \(forecastHour.chanceOfRain)%")
                    Text("Chance of Snow: \(forecastHour.chanceOfSnow)%")
                }.padding(.bottom).frame(maxWidth: .infinity, alignment: .leading)
            }.padding([.top, .leading, .trailing])
        }
    }
}

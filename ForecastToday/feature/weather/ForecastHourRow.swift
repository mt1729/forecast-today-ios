//
// Created by Matthew Taylor on 3/24/22.
//

import SwiftUI
import Foundation

struct ForecastHourRow: View {
    let forecastHour: ForecastHour
    init(forecastHour: ForecastHour) {
        self.forecastHour = forecastHour
    }

    var body: some View {
        NavigationLink(destination: ForecastDetailView(forecastHour: forecastHour)) {
            HStack {
                AsyncImage(
                    // TODO: - Mutate URI in response logic
                    url: URL(string: "https:\(forecastHour.condition.iconURI)"),
                    content: { img in
                        img.resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                    },
                    placeholder: { ProgressView().frame(width: 50, height: 50) }
                )
                Text("\(forecastHour.time.components(separatedBy: " ").last ?? "")")
                Spacer()
                Text("\(forecastHour.tempF.choppedZeroesString())&deg; F")
                    .padding(.trailing)
            }
        }
    }
}

class ForecastHourRow_Previews: PreviewProvider {
    static let mockForecastHour = ForecastResponse.fromJSON(fileName: "forecastResponse")!
        .forecast.daysInfo.first!.hour.first!

    static var previews: some View {
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

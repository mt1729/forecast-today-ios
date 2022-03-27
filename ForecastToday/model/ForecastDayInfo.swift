//
// Created by Matthew Taylor on 3/27/22.
//

import Foundation

struct ForecastDayInfo: Codable {
    let day: ForecastDay
    let date: String
    let hour: [ForecastHour]
    let astro: ForecastAstrology
    let dateEpoch: Int

    enum CodingKeys: String, CodingKey {
        case day
        case date
        case hour
        case astro
        case dateEpoch = "date_epoch"
    }
}

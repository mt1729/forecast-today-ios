//
// Created by Matthew Taylor on 3/27/22.
//

import Foundation

struct ForecastLocation: Codable {
    let lat: Double
    let lon: Double
    let tzID: String
    let name: String
    let region: String
    let country: String
    let localtime: String
    let localtimeEpoch: Int

    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case tzID = "tz_id"
        case name
        case region
        case country
        case localtime
        case localtimeEpoch = "localtime_epoch"
    }
}

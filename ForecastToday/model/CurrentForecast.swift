//
// Created by Matthew Taylor on 3/27/22.
//

import Foundation

struct CurrentForecast: Codable {
    let isDay: Int
    let tempC: Double
    let tempF: Double
    let windMph: Double
    let windKph: Double
    let precipMm: Double
    let precipIn: Double
    let condition: ForecastCondition
    let lastUpdated: String
    let lastUpdatedEpoch: Int
    let windDegree: Int
    let windDir: String
    let pressureMB: Double
    let pressureIn: Double
    let humidity, cloud: Int
    let feelslikeC, feelslikeF: Double
    let visKM, visMiles: Double
    let gustMph, gustKph, uv: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

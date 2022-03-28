//
// Created by Matthew Taylor on 3/27/22.
//

import Foundation

struct ForecastHour: Codable, Identifiable, Hashable {
    let id = UUID()

    let timeEpoch: Int
    let time: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: ForecastCondition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMB, pressureIn: Double
    let precipMm, precipIn: Double
    let humidity, cloud: Int
    let feelslikeC, feelslikeF, windchillC, windchillF: Double
    let heatindexC, heatindexF, dewpointC, dewpointF: Double
    let willItRain, chanceOfRain, willItSnow, chanceOfSnow: Int
    let visKM, visMiles: Double
    let gustMph, gustKph: Double
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case uv
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case condition
        case timeEpoch = "time_epoch"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ForecastHour, rhs: ForecastHour) -> Bool {
        lhs.id == rhs.id
    }
}

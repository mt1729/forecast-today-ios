//
// Created by Matthew Taylor on 3/27/22.
//

import Foundation

struct ForecastDay: Codable {
    let uv: Double
    let avgtempC: Double
    let avgtempF: Double
    let mintempC: Double
    let maxtempC: Double
    let mintempF: Double
    let maxtempF: Double
    let avgvisKM: Double
    let condition: ForecastCondition
    let maxwindMph: Double
    let maxwindKph: Double
    let avghumidity: Int
    let avgvisMiles: Double
    let totalprecipMm: Double
    let totalprecipIn: Double

    enum CodingKeys: String, CodingKey {
        case uv
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case avgvisKM = "avgvis_km"
        case condition
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case avghumidity
        case avgvisMiles = "avgvis_miles"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
    }
}

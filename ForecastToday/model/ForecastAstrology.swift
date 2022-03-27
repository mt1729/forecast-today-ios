//
// Created by Matthew Taylor on 3/27/22.
//

import Foundation

struct ForecastAstrology: Codable {
    let sunset: String
    let sunrise: String
    let moonset: String
    let moonrise: String
    let moonPhase: String

    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonPhase = "moon_phase"
    }
}

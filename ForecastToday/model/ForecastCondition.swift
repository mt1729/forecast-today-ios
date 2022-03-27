//
// Created by Matthew Taylor on 3/27/22.
//

import Foundation

struct ForecastCondition: Codable {
    let code: Int
    let text: String
    let iconURI: String

    enum CodingKeys: String, CodingKey {
        case code
        case text
        case iconURI = "icon"
    }
}

//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

struct HourlyForecastBody {
    let zipCode: String

    init (_ zipCode: String) {
        self.zipCode = zipCode
    }
}

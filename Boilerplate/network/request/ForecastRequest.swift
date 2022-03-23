//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

struct ForecastRequest {
    let zipCode: String

    init (_ zipCode: String) {
        self.zipCode = zipCode
    }
}

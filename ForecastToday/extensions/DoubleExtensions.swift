//
// Created by Matthew Taylor on 3/26/22.
//

import Foundation

extension Double {
    func choppedZeroesString() -> String {
        truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

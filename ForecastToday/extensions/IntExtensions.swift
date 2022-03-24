//
// Created by Matthew Taylor on 3/22/22.
//

import Foundation

extension Int {
    var isHTTPSuccess: Bool {
        200...299 ~= self
    }
}

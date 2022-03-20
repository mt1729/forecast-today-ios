//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

enum NetworkResult<T> {
    case success(_ result: T)
    case pending
    case error(_ error: Error)
}

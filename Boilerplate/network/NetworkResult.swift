//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

enum NetworkResult<T> {
    case empty
    case success(_ statusCode: Int, _ result: T)
    case pending
    case failure(_ statusCode: Int)
    case error(_ error: Error)
}

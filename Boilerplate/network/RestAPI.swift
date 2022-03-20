//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

protocol RestAPI {
    func login(_ loginBody: LoginBody) async throws -> User
}

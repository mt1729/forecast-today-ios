//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

struct BoilerplateRestAPI: RestAPI {
    func login(_ loginBody: LoginBody) async throws -> User {
        User(id: 0, username: "TODO")
    }
}

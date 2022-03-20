//
// Created by Matthew Taylor on 3/19/22.
//

import Foundation

struct AuthRepository {
    let api: RestAPI

    init (restAPI api: RestAPI) {
        self.api = api
    }

    func login(username: String, password: String) async -> NetworkResult<User> {
        do {
            let reqBody = LoginBody(username, password)

            let res = try await api.login(reqBody)
//            let resBody = Optional(NSObject())
//            let resCode =

//            if let resBody = resBody {
//
//            }
        } catch {
            return NetworkResult.error(error)
        }
    }
}

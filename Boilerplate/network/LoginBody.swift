//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

struct LoginBody {
    let username, password: String

    init(_ username: String, _ password: String) {
        self.username = username
        self.password = password
    }
}

//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

struct User: Codable {
    let id: Int, username: String

    init(id: Int, username: String) {
        self.id = id
        self.username = username
    }
}

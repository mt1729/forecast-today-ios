//
// Created by Matthew Taylor on 3/20/22.
//

import Foundation

enum Environment {
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist not found")
        }
        return dict
    }()

    static let apiRoot: String = {
        guard let value = Environment.infoDict["API_ROOT"] as? String else {
            fatalError("Missing plist key for 'API_ROOT'")
        }
        return value
    }()

    static let apiKey: String = {
        guard let value = Environment.infoDict["API_KEY"] as? String else {
            fatalError("Missing plist key for 'API_KEY'")
        }
        return value
    }()
}

//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct ServiceAPI {
    // MARK: - Properties
    static let secureProtocolFormat = "https://"
    static let contentServer = "content.viaplay.se"
}

struct ServiceEndpoint {
    static let ios = "/ios-se"
}

protocol PropertyReflectable { }

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        return m.children.first { $0.label == key }?.value
    }
}

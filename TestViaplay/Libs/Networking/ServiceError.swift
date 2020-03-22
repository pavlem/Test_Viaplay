//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//
import Foundation

enum ServiceError: Error {
    case noInternetConnection
    case serverHostnameNotAvailable
    case custom(String)
    case other
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet Connection"
        case .custom(let message):
            return message
        case .other:
            return "Other"
        case .serverHostnameNotAvailable:
            return "Server Hostname Not Available"
        }
    }
}
extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

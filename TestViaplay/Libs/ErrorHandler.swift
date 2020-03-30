//
//  ErrorHandler.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 30/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

struct ErrorHandlerStrings {
    static let noNet = "No Internet, please try again later"
}

struct ErrorHandler {
    static func handle(error: ServiceError?, vc: UIViewController) {
        guard let error = error else { return }
        
        switch error {
        case .noInternetConnection:
            AlertHelper.simpleAlert(message: ErrorHandlerStrings.noNet, vc: vc) {
                BlockScreen.hideBlocker()
            }
        default:
            print(error) // Here we can hanlde errors as we wish....
        }
    }
}

//
//  AlertHelper.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 30/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

struct AlertHelper {
    static func simpleAlert(title: String? = nil, message: String? = nil, vc: UIViewController, success: @escaping ()->()) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            success()
        }

        alertController.addAction(okAction)
        vc.present(alertController, animated: true) {}
    }
}

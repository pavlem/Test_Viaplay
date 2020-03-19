//
//  UIStoryboard+extension.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var mainSB: UIStoryboard { return UIStoryboard(name: "Main", bundle: nil) }

    static var startVC: StartVC { return mainSB.instantiateViewController(identifier: "StartVC_ID") as! StartVC }

}

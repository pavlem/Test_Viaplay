//
//  UIStoryboard+extension.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    // MARK: Storyboards
    static var mainSB: UIStoryboard { return UIStoryboard(name: "Main", bundle: nil) }

    // MARK: View Controllers
    static var startVC: StartVC { return mainSB.instantiateViewController(identifier: "StartVC_ID") as! StartVC }
    static var sectionCVC: SectionCVC { return mainSB.instantiateViewController(identifier: "SectionCVC_ID") as! SectionCVC }
}

//
//  FetchTimeoutHelper.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 30/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

class FetchTimeoutHelper {
    
    // MARK: - API
    static let shared = FetchTimeoutHelper()
    
    var isSectionsFetchNeeded: Bool {
        
        let secondsNow = Date().seconds(sinceDate: Date())!
        let secondsMostRecenFetch = Date().seconds(sinceDate: mostRecentSectionsFetch)!
        
        print("Next fetch possible in: ")
        print(sectionsFetchCooldownPeriod - (secondsMostRecenFetch-secondsNow))

        guard secondsMostRecenFetch - secondsNow > sectionsFetchCooldownPeriod || isFirstSectionFetch else {
            return false
        }
        
        isFirstSectionFetch = false
        mostRecentSectionsFetch = Date()
        return true
    }
    
    // MARK: - Properties
    private let sectionsFetchCooldownPeriod = 6
    private var isFirstSectionFetch = true
    private var mostRecentSectionsFetch = Date()
}

extension Date {
    func seconds(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: sinceDate, to: self).second
    }
}

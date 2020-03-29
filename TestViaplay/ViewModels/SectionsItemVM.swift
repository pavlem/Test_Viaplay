//
//  SectionItemVM.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 23/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct SectionsItemVM {
    let url: String
    let title: String
}

extension SectionsItemVM {
    init(sectionsResponseItem: SectionsResponseItem) {
        self.url = sectionsResponseItem.href ?? ""
        self.title = sectionsResponseItem.title ?? ""
    }
}

extension SectionsItemVM {
    var path: String {
        var sectionUrl = self.url
        let stringsToRemove = ["https://content.viaplay.se/ios-se", "{?dtg}"]
        for str in stringsToRemove {
            sectionUrl = sectionUrl.replacingOccurrences(of: str, with: "")
        }
        return sectionUrl
    }
}

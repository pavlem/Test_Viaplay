//
//  SectionCVCHeaderVM.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 23/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct SectionCVCHeaderVM {
    let title: String
    let description: String
}

extension SectionCVCHeaderVM {
    init(sectionsResponse: SectionsResponse) {
        title = sectionsResponse.title ?? "No title"
        description = "Description: " + (sectionsResponse.description ?? "No description")
    }
}

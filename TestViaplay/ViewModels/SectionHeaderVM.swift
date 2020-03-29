//
//  SectionHeaderVM.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 29/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct SectionHeaderVM {
    let title: String
    let description: String
}

extension SectionHeaderVM {
    init(sectionResponse: SectionResponse) {
        self.title = sectionResponse.title ?? ""
        self.description = sectionResponse.description ?? ""
    }
}

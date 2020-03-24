//
//  SectionItemVM.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 23/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct SectionItemVM {
    let url: String
    let title: String
}

extension SectionItemVM {
    init(sectionsResponseItem: SectionsResponseItem) {
        self.url = sectionsResponseItem.href ?? ""
        self.title = sectionsResponseItem.title ?? ""
    }
}

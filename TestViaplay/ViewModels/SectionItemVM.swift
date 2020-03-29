//
//  SectionVM.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 29/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct SectionItemVM {
    let title: String
    let type: String    
}

extension SectionItemVM {
    init(sectionResponseItem: SectionResponseItem) {
        self.title = sectionResponseItem.title ?? ""
        self.type = sectionResponseItem.type ?? ""
    }
}

//
//  SectionResponse.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 22/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct SectionResponseItem: Decodable {
    let title: String?
    let href: String?
    let tagId: String?
}

struct SectionResponseLinks: Decodable {
    let viaplayCategoryFilters: [SectionResponseItem]?
    
    private enum CodingKeys : String, CodingKey {
        case viaplayCategoryFilters = "viaplay:categoryFilters"
    }
}

struct SectionResponse: Decodable {
    let type: String?
    let title: String?
    let description: String?
    let pageType: String?
    let sectionId: String?
    let links: SectionResponseLinks?
    
    private enum CodingKeys : String, CodingKey {
        case type, title, description, pageType, sectionId, links = "_links"
    }
}

//
//  SectionResponse.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 20/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct SectionsResponseItem: Decodable {
    let templated: Bool?
    let id: String?
    let title: String?
    let href: String?
    let type: String?
    let name: String?
}

struct SectionsResponseLinks: Decodable {
    let viaplaySections: [SectionsResponseItem]?
    
    private enum CodingKeys : String, CodingKey {
        case viaplaySections = "viaplay:sections"
    }
}

struct SectionsResponse: Decodable {
    let title: String?
    let description: String?
    let links: SectionsResponseLinks?
    
    private enum CodingKeys : String, CodingKey {
        case title, description, links = "_links"
    }
}

//
//  TestViaplayTests.swift
//  TestViaplayTests
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import XCTest
@testable import TestViaplay

class TestViaplayTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSectionCVCHeaderVM() {
        let sectionsResponse1 = SectionsResponse(title: "Nice Title", description: "This is a very, very nice title", links: nil)
        let sectionCVCHeaderVM1 = SectionCVCHeaderVM(sectionsResponse: sectionsResponse1)
        
        let sectionsResponse2 = SectionsResponse(title: nil, description: nil, links: nil)
        let sectionCVCHeaderVM2 = SectionCVCHeaderVM(sectionsResponse: sectionsResponse2)
        
        XCTAssert(sectionCVCHeaderVM1.title == "Nice Title")
        XCTAssert(sectionCVCHeaderVM1.description == "Description: This is a very, very nice title", "Not sdsdfdsfdsfsdf")
        
        XCTAssert(sectionCVCHeaderVM2.title == "No title")
        XCTAssert(sectionCVCHeaderVM2.description == "Description: No description")
    }
}

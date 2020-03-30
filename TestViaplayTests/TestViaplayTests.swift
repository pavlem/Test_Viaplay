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
    
    func testSectionsCVCHeaderVM() {
        let sectionsResponse1 = SectionsResponse(title: "Nice Title", description: "This is a very, very nice title", links: nil)
        let sectionCVCHeaderVM1 = SectionsCVCHeaderVM(sectionsResponse: sectionsResponse1)
        
        let sectionsResponse2 = SectionsResponse(title: nil, description: nil, links: nil)
        let sectionCVCHeaderVM2 = SectionsCVCHeaderVM(sectionsResponse: sectionsResponse2)
        
        XCTAssert(sectionCVCHeaderVM1.title == "Nice Title", "testSectionsCVCHeaderVM not ok")
        XCTAssert(sectionCVCHeaderVM1.description == "Description: This is a very, very nice title", "testSectionsCVCHeaderVM not ok")
        
        XCTAssert(sectionCVCHeaderVM2.title == "No title", "testSectionsCVCHeaderVM not ok")
        XCTAssert(sectionCVCHeaderVM2.description == "Description: No description", "testSectionsCVCHeaderVM not ok")
    }
    
    func testSectionsItemVMPath() {
        let sectionsItemVM1 = SectionsItemVM(url: "https://content.viaplay.se/ios-se/serier{?dtg}", title: "")
        let sectionsItemVM2 = SectionsItemVM(url: "https://content.viaplay.se/ios-se/film{?dtg}", title: "")
        let sectionsItemVM3 = SectionsItemVM(url: "https://content.viaplay.se/ios-se/sport3{?dtg}", title: "")
        let sectionsItemVM4 = SectionsItemVM(url: "https://content.viaplay.se/ios-se/sport2{?dtg}", title: "")
        let sectionsItemVM5 = SectionsItemVM(url: "https://content.viaplay.se/ios-se/sport{?dtg}", title: "")
        let sectionsItemVM6 = SectionsItemVM(url: "https://content.viaplay.se/ios-se/barn{?dtg}", title: "")

        XCTAssert(sectionsItemVM1.path == "/serier", "testSectionsCVCHeaderVM not ok")
        XCTAssert(sectionsItemVM2.path == "/film", "testSectionsCVCHeaderVM not ok")
        XCTAssert(sectionsItemVM3.path == "/sport3", "testSectionsCVCHeaderVM not ok")
        XCTAssert(sectionsItemVM4.path == "/sport2", "testSectionsCVCHeaderVM not ok")
        XCTAssert(sectionsItemVM5.path == "/sport", "testSectionsCVCHeaderVM not ok")
        XCTAssert(sectionsItemVM6.path == "/barn", "testSectionsCVCHeaderVM not ok")
    }
}

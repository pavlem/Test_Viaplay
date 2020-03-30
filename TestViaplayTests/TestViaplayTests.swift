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

        XCTAssert(sectionsItemVM1.path == "/serier", "testSectionsItemVMPath not ok")
        XCTAssert(sectionsItemVM2.path == "/film", "testSectionsItemVMPath not ok")
        XCTAssert(sectionsItemVM3.path == "/sport3", "testSectionsItemVMPath not ok")
        XCTAssert(sectionsItemVM4.path == "/sport2", "testSectionsItemVMPath not ok")
        XCTAssert(sectionsItemVM5.path == "/sport", "testSectionsItemVMPath not ok")
        XCTAssert(sectionsItemVM6.path == "/barn", "testSectionsItemVMPath not ok")
    }
    
    func testSectionItemVM() {
        
        let sectionResponseItem1 = SectionResponseItem(title: "Title 1", type: "Type 1", href: "")
        let sectionResponseItem2 = SectionResponseItem(title: "TITLE 2", type: "TYPE 2", href: "")
        let sectionResponseItem3 = SectionResponseItem(title: "title 3", type: "type 3", href: "")
        
        let sectionItemVM1 = SectionItemVM(sectionResponseItem: sectionResponseItem1)
        let sectionItemVM2 = SectionItemVM(sectionResponseItem: sectionResponseItem2)
        let sectionItemVM3 = SectionItemVM(sectionResponseItem: sectionResponseItem3)

        XCTAssert(sectionItemVM1.title == "Title 1", "testSectionItemVM not ok")
        XCTAssert(sectionItemVM1.type == "TYPE 1", "testSectionItemVM not ok")

        XCTAssert(sectionItemVM2.title == "Title 2", "testSectionItemVM not ok")
        XCTAssert(sectionItemVM2.type == "TYPE 2", "testSectionItemVM not ok")

        XCTAssert(sectionItemVM3.title == "Title 3", "testSectionItemVM not ok")
        XCTAssert(sectionItemVM3.type == "TYPE 3", "testSectionItemVM not ok")
    }
    
    func testSectionHeaderVM() {
        let sectionResponse1 = SectionResponse(type: "", title: "Title 1", description: "Description 1", pageType: nil, sectionId: nil, links: nil)
        let sectionResponse2 = SectionResponse(type: "", title: "title 2", description: "description 2", pageType: nil, sectionId: nil, links: nil)
        
        let sectionHeaderVM1 = SectionHeaderVM(sectionResponse: sectionResponse1)
        let sectionHeaderVM2 = SectionHeaderVM(sectionResponse: sectionResponse2)

        XCTAssert(sectionHeaderVM1.title == "TITLE 1", "testSectionHeaderVM not ok")
        XCTAssert(sectionHeaderVM1.description == "Description 1", "testSectionHeaderVM not ok")

        XCTAssert(sectionHeaderVM2.title == "TITLE 2", "testSectionHeaderVM not ok")
        XCTAssert(sectionHeaderVM2.description == "Description 2", "testSectionHeaderVM not ok")
    }
}

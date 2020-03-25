//
//  Corona_Tracker_Tests.swift
//  Corona Tracker Tests
//
//  Created by Emily Jewik on 3/24/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import XCTest

@testable import Corona_Tracker

class Corona_Tracker_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegion() {
        
        let region : Region = Region(level: Region.Level(rawValue: 2)!, name: "country", parentName: "world", location: Coordinate.zero)
        
        XCTAssertEqual(2, region.level.rawValue)
    }

}

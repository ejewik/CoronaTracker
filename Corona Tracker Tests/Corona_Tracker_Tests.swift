//
//  Corona_Tracker_Tests.swift
//  Corona Tracker Tests
//
//  Created by Emily Jewik on 3/24/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import XCTest

@testable import Corona_Tracker

class Corona_Tracker_Test_Models: XCTestCase {
    
    func testRegionConstructor() {
        
        let region : Region = Region(level: Region.Level(rawValue: 2)!, name: "testName", parentName: "testParentName", location: Coordinate.zero)
        
        XCTAssertEqual(2, region.level.rawValue)
        XCTAssertEqual("testName", region.name)
        XCTAssertEqual("testParentName", region.parentName)
        XCTAssertEqual(Coordinate.zero, region.location)
    }
    
    func testFindRegion() {
        
        let region : Region = Region(level: Region.Level(rawValue: 2)!, name: "testName", parentName: "testParentName", location: Coordinate.zero)
        let sameRegion = region.find(region: region)
        
        XCTAssertEqual(region, sameRegion)
        
    }
    
    func testStatisticConstructor() {
        
        let statistic : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        
        XCTAssertEqual(100, statistic.confirmedCount)
        XCTAssertEqual(10, statistic.recoveredCount)
        XCTAssertEqual(2, statistic.deathCount)
        
    }
    
    func testStatisticGetNumber() {
        
         let statistic : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        
        XCTAssertEqual(100, statistic.number(for: .confirmed))
        XCTAssertEqual(10, statistic.number(for: .recovered))
        XCTAssertEqual(2, statistic.number(for: .deaths))
        XCTAssertEqual(88, statistic.number(for: .active))
        
    }
    
    func testStatisticSum() {
        
        let statisticToSum1 : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        let statisticToSum2 : Statistic = Statistic(confirmedCount: 50, recoveredCount: 5, deathCount: 3)
        let statisticsToSum : [Statistic] = [statisticToSum1, statisticToSum2]
        
        let sumStatistic : Statistic = Statistic.sum(subData: statisticsToSum)
        
        XCTAssertEqual(150, sumStatistic.confirmedCount)
        XCTAssertEqual(15, sumStatistic.recoveredCount)
        XCTAssertEqual(5, sumStatistic.deathCount)
    }

}

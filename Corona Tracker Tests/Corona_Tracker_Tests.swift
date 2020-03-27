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
    
    //Coordinate Model Unit Tests
    func testCoordinateConstructor() {
        
        let coord : Coordinate = Coordinate(latitude: 10, longitude: -10)
        XCTAssertEqual(10, coord.latitude)
        XCTAssertEqual(-10, coord.longitude)
        
    }
    
    func testCoordinateDistance() {
        
        let coord1 : Coordinate = Coordinate(latitude: 10, longitude: 0)
        let coord2 : Coordinate = Coordinate(latitude: 0, longitude: 0)
        
        let distance = coord1.distance(from: coord2)
        
        XCTAssertEqual(10, distance)
        
    }
    
    func testCoordinateCenter() {
        
        let coord1 : Coordinate = Coordinate(latitude: 11, longitude: 0)
        let coord2 : Coordinate = Coordinate(latitude: -10, longitude: 0)
        
        let coords : [Coordinate] = [coord1, coord2]
        
        let center = Coordinate.center(of: coords)
        
    }
    
    //Region Model Unit Tests
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
    
    //Statistic Model Unit Tests
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
    
    //Change Model Unit Test
    func testChangeSum() {
        
        let lastStatistic : Statistic = Statistic(confirmedCount: 50, recoveredCount: 5, deathCount: 3)
        let currentStatistic : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 5)
        
        let changeToSum1 : Change = Change(currentStat: currentStatistic, lastStat: lastStatistic)
        let changeToSum2 : Change = Change(currentStat: currentStatistic, lastStat: lastStatistic)
        
        let changesToSum : [Change] = [changeToSum1, changeToSum2]
        
        let sumChange : Change = Change.sum(subChanges: changesToSum)
        
        XCTAssertEqual(100, sumChange.newConfirmed)
    }
    
    //Report Model Unit Tests
    func testReportConstructor() {
        
        let statistic : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        
        let report : Report = Report(lastUpdate: Date(timeIntervalSince1970: 0), stat: statistic)
        
        XCTAssertEqual(Date(timeIntervalSince1970: 0), report.lastUpdate)
        XCTAssertEqual(statistic.activeCount, report.stat.activeCount)
        XCTAssertEqual(statistic.confirmedCount, report.stat.confirmedCount)
        XCTAssertEqual(statistic.deathCount, report.stat.deathCount)
        XCTAssertEqual(statistic.recoveredCount, report.stat.recoveredCount)
    }
    
    func testReportJoin() {
        
        let statistic1 : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        
        let statistic2 : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        
        let reportToJoin1 : Report = Report(lastUpdate: Date(timeIntervalSince1970: 0), stat: statistic1)
        let reportToJoin2 : Report = Report(lastUpdate: Date(timeIntervalSince1970: 1), stat: statistic2)
        
        let reportsToJoin : [Report] = [reportToJoin1, reportToJoin2]
        
        let joinedReport : Report = Report.join(subReports: reportsToJoin)
        
        XCTAssertEqual(Date(timeIntervalSince1970: 1), joinedReport.lastUpdate)
        XCTAssertEqual(176, joinedReport.stat.activeCount)
        XCTAssertEqual(200, joinedReport.stat.confirmedCount)
        XCTAssertEqual(4, joinedReport.stat.deathCount)
        XCTAssertEqual(20, joinedReport.stat.recoveredCount)

    }
    
    //TimeSeries Unit Tests
    func testTimeSeriesConstructor() {
        
        let statistic1 : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        let statistic2 : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        
        var series = [Date : Statistic]()
        series[Date(timeIntervalSince1970: 0)] = statistic1
        series[Date(timeIntervalSince1970: 1)] = statistic2
        
        let timeseries : TimeSeries = TimeSeries(series: series)
        
        XCTAssertEqual(series[Date(timeIntervalSince1970: 0)]?.activeCount, timeseries.series[Date(timeIntervalSince1970: 0)]?.activeCount)
        XCTAssertEqual(series[Date(timeIntervalSince1970: 1)]?.activeCount, timeseries.series[Date(timeIntervalSince1970: 1)]?.activeCount)
        
    }
    
    func testTimeSeriesJoin() {
        
        let statistic1 : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        let statistic2 : Statistic = Statistic(confirmedCount: 100, recoveredCount: 10, deathCount: 2)
        
        var seriesToJoin1 = [Date : Statistic]()
        seriesToJoin1[Date(timeIntervalSince1970: 0)] = statistic1
        seriesToJoin1[Date(timeIntervalSince1970: 1)] = statistic2
        
        let statistic3 : Statistic = Statistic(confirmedCount: 50, recoveredCount: 5, deathCount: 1)
        
        var seriesToJoin2 = [Date : Statistic]()
        seriesToJoin2[Date(timeIntervalSince1970: 3)] = statistic3
        
        let timeseriesToJoin1 : TimeSeries = TimeSeries(series: seriesToJoin1)
        let timeseriesToJoin2 : TimeSeries = TimeSeries(series: seriesToJoin2)
        
        let timeSerieses : [TimeSeries] = [timeseriesToJoin1, timeseriesToJoin2]
        
        let joinedTimeSeries : TimeSeries = TimeSeries.join(subSerieses: timeSerieses)!
        
        XCTAssertEqual(88, joinedTimeSeries.series[Date(timeIntervalSince1970: 0)]?.activeCount)
        XCTAssertEqual(44, joinedTimeSeries.series[Date(timeIntervalSince1970: 1)]?.activeCount)
        
    }

}

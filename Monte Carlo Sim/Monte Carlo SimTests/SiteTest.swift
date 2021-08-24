//
//  SiteTest.swift
//  Monte Carlo SimTests
//
//  Created by Joshua Stephenson on 8/23/21.
//

import XCTest

class SiteTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdjascentSites() throws {
        let grid = GridModel(n: 3)
        if let site = grid.siteFor(row: 1, col: 1) {
            XCTAssert(site.left == nil)
            XCTAssert(site.above == nil)
            XCTAssert(site.right!.row == 1 && site.right!.col == 2)
            XCTAssert(site.below!.row == 2 && site.below!.col == 1)
        }
        if let site = grid.siteFor(row: 1, col: 2) {
            XCTAssert(site.left!.row == 1 && site.left!.col == 1)
            XCTAssert(site.above == nil)
            XCTAssert(site.right!.row == 1 && site.right!.col == 3)
            XCTAssert(site.below!.row == 2 && site.below!.col == 2)
        }
        if let site = grid.siteFor(row: 1, col: 3) {
            XCTAssert(site.left!.row == 1 && site.left!.col == 2)
            XCTAssert(site.above == nil)
            XCTAssert(site.right == nil)
            XCTAssert(site.below!.row == 2 && site.below!.col == 3)
        }
        
        // second row
        if let site = grid.siteFor(row: 2, col: 1) {
            XCTAssert(site.left == nil)
            XCTAssert(site.above!.row == 1 && site.above!.col == 1)
            XCTAssert(site.right!.row == 2 && site.right!.col == 2)
            XCTAssert(site.below!.row == 3 && site.below!.col == 1)
        }
        if let site = grid.siteFor(row: 2, col: 2) {
            XCTAssert(site.left!.row == 2 && site.left!.col == 1)
            XCTAssert(site.above!.row == 1 && site.above!.col == 2)
            XCTAssert(site.right!.row == 2 && site.right!.col == 3)
            XCTAssert(site.below!.row == 3 && site.below!.col == 2)
        }
        if let site = grid.siteFor(row: 2, col: 3) {
            XCTAssert(site.left!.row == 2 && site.left!.col == 2)
            XCTAssert(site.above!.row == 1 && site.above!.col == 3)
            XCTAssert(site.right == nil)
            XCTAssert(site.below!.row == 3 && site.below!.col == 3)
        }
        
        // third row
        if let site = grid.siteFor(row: 3, col: 1) {
            XCTAssert(site.left == nil)
            XCTAssert(site.above!.row == 2 && site.above!.col == 1)
            XCTAssert(site.right!.row == 3 && site.right!.col == 2)
            XCTAssert(site.below == nil)
        }
        if let site = grid.siteFor(row: 3, col: 2) {
            XCTAssert(site.left!.row == 3 && site.left!.col == 1)
            XCTAssert(site.above!.row == 2 && site.above!.col == 2)
            XCTAssert(site.right!.row == 3 && site.right!.col == 3)
            XCTAssert(site.below == nil)
        }
        if let site = grid.siteFor(row: 3, col: 3) {
            XCTAssert(site.left!.row == 3 && site.left!.col == 2)
            XCTAssert(site.above!.row == 2 && site.above!.col == 3)
            XCTAssert(site.right == nil)
            XCTAssert(site.below == nil)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

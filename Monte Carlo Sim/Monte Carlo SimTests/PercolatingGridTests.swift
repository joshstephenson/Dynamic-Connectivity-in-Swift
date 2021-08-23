//
//  PercolatingGridTests.swift
//  Monte Carlo SimTests
//
//  Created by Joshua Stephenson on 8/23/21.
//

import XCTest

class PercolatingGridTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGridPercolation() throws {
        let grid = PercolatingGrid(3)
        grid.open(row: 1, col: 1)
        grid.open(row: 2, col: 1)
        XCTAssert(!grid.percolates())
        grid.open(row: 3, col: 1)
        XCTAssert(grid.percolates())
    }
    
    func testSiteFull() throws {
        let grid = PercolatingGrid(3)
        XCTAssert(!grid.isOpen(row: 2, col: 1))
        grid.open(row: 2, col: 1)
        XCTAssert(!grid.isFull(row: 2, col: 1))
        grid.open(row: 1, col: 1)
        XCTAssert(grid.isFull(row: 2, col: 1))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

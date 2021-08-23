//
//  ShortestPercolatingPathTest.swift
//  Monte Carlo SimTests
//
//  Created by Joshua Stephenson on 8/23/21.
//

import XCTest

class ShortestPercolatingPathTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let grid = PercolatingGrid(3)
        grid.open(row: 1, col: 1)
        grid.open(row: 2, col: 1)
        grid.open(row: 3, col: 1)
        let shortest = ShortestPercolatingPath(grid)
        var index = 1
        let path = shortest.path()
        XCTAssert(path.count == 3)
        shortest.path().forEach { site in
            XCTAssert(site.col == 1)
            XCTAssert(site.row == index)
            index += 1
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

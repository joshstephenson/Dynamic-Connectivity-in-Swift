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

    func testMostDirectPercolationPath() throws {
        let gridModel = GridModel(n: 3)
        gridModel.siteFor(row: 1, col: 1)?.open()
        gridModel.siteFor(row: 2, col: 1)?.open()
        gridModel.siteFor(row: 3, col: 1)?.open()
        
        let shortest = ShortestPercolatingPath(gridModel)
        var index = 3
        let path = shortest.path()
        print(path)
        XCTAssert(path.count == 3)
        shortest.path().forEach { site in
            XCTAssert(site.col == 1)
            XCTAssert(site.row == index)
            index -= 1
        }
    }
    
    func testIndirectPercolationPath() throws {
        let gridModel = GridModel(n: 3)
        gridModel.siteFor(row: 1, col: 3)?.open()
        gridModel.siteFor(row: 2, col: 3)?.open()
        gridModel.siteFor(row: 2, col: 2)?.open()
        gridModel.siteFor(row: 2, col: 1)?.open()
        gridModel.siteFor(row: 3, col: 1)?.open()
        XCTAssert(gridModel.grid.percolates())
        
        let shortest = ShortestPercolatingPath(gridModel)
        let path = shortest.path()
        XCTAssert(path.count == 5)
        let expected:[[Int]] = [[3,1], [2,1], [2,2], [2,3], [1,3]]
        var index = 0
        shortest.path().forEach { site in
            let expect = expected[index]
            XCTAssert(site.row == expect[0])
            XCTAssert(site.col == expect[1])
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

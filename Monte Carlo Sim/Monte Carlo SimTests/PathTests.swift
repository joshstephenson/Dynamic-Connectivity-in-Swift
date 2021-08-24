//
//  PathTests.swift
//  Monte Carlo SimTests
//
//  Created by Joshua Stephenson on 8/23/21.
//

import XCTest

class MockSite {
    var row:Int
    var col:Int
    init(row:Int, col: Int) {
        self.row = row
        self.col = col
    }
}

class PathTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdjascentSites() throws {
//        let gridModel = GridModel(n: 3)
//        let grid = gridModel.grid
//        
//        // first, open all sites
//        for i in 1...3 {
//            for j in 1...3 {
//                grid.open(row: i, col: j)
//            }
//        }
//        
//        let path = Path(from: Site(row: 1, col: 1, gridModel: gridModel),
//                        to: Site(row: 3, col: 1, gridModel: gridModel), gridModel: gridModel)
//        
//        var adjascent = path.openSitesAdjascentTo(row: 1, col: 1)
//        var expected:[MockSite] = [MockSite(row: 1, col: 2),
//                                   MockSite(row: 2, col: 1)
//        ]
//        adjascent.forEach { site in
//            XCTAssert(expected.map({ ms in
//                return site.row == ms.row && site.col == ms.col
//            }).contains(true))
//        }
//
//        adjascent = path.openSitesAdjascentTo(row: 3, col: 3)
//        expected = [MockSite(row: 2, col: 3),
//                    MockSite(row: 3, col: 2)
//        ]
//        adjascent.forEach { site in
//            XCTAssert(expected.map({ ms in
//                return site.row == ms.row && site.col == ms.col
//            }).contains(true))
//        }
//
//        adjascent = path.openSitesAdjascentTo(row: 2, col: 2)
//        expected = [MockSite(row: 1, col: 2),
//                    MockSite(row: 2, col: 1),
//                    MockSite(row: 2, col: 3),
//                    MockSite(row: 3, col: 2)
//        ]
//        adjascent.forEach { site in
//            XCTAssert(expected.map({ ms in
//                return site.row == ms.row && site.col == ms.col
//            }).contains(true))
//        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

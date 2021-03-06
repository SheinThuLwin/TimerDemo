//
//  TimerDemoTests.swift
//  TimerDemoTests
//
//  Created by ut-i02 on 22/03/2022.
//

import XCTest
@testable import TimerDemo

class TimerDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTimeString() throws {
        let vc = TimerControl()
        
        XCTAssertEqual(vc.getTimeString(seconds: 0), "00:00")
        XCTAssertEqual(vc.getTimeString(seconds: 9), "00:09")
        XCTAssertEqual(vc.getTimeString(seconds: 65), "01:05")
        XCTAssertEqual(vc.getTimeString(seconds: 664), "11:04")
        XCTAssertEqual(vc.getTimeString(seconds: 674), "11:14")
        XCTAssertEqual(vc.getTimeString(seconds: 18674), "05:11:14")
        XCTAssertEqual(vc.getTimeString(seconds: 36674), "10:11:14")
        XCTAssertEqual(vc.getTimeString(seconds: 360674), "100:11:14")
    }

}

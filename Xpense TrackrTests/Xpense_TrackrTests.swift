//
//  Xpense_TrackrTests.swift
//  Xpense TrackrTests
//
//  Created by CHRIS CHONG on 28/04/2017.
//  Copyright © 2017 CHRIS CHONG. All rights reserved.
//

import XCTest
@testable import Xpense_Trackr

class Xpense_TrackrTests: XCTestCase {
    
    func testExpenseInit(){
        let zeroTest = Expenses.init(name:"doob", photo: nil, value: 0)
        XCTAssertNotNil(zeroTest)
        
        let normalValue = Expenses.init(name:"doob", photo: nil, value: 100.00)
        XCTAssertNotNil(normalValue)

    }
    
}

//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by RuslanS on 9/25/22.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!       //Most/All objects are unwrapped here
    
    
    override func setUp() {                 //Gets run once per unit test
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)                 //Inputs 929466.23 into dollarsFormatted func
        XCTAssertEqual(result, "$929,466.23")                           //Checks if result of dollarsFormatted func is "$929,466.00"
    }
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
    }
    
}

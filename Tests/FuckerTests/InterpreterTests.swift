//
//  InterpreterTests.swift
//  FuckerTests
//
//  Created by Maddie Schipper on 3/7/18.
//

import XCTest
@testable import FuckerCore

class InterpreterTests: XCTestCase {
    func testHelloWorld() {
        let input = "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
        let output = try! Interpreter.run(input)
        XCTAssertEqual(output, "Hello World!\n")
    }
}


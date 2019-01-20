//
//  ParserTests.swift
//  FuckerTests
//
//  Created by Maddie Schipper on 3/7/18.
//

import XCTest
@testable import FuckerCore

class ParserTests: XCTestCase {
    func testParser() {
        let input = """
>    increment the data pointer
<    decrement the data pointer
+    increment the byte at the data pointer
-    decrement the byte at the data pointer
.    output the byte at the data pointer
,    accept one byte of input storing its value in the byte at the data pointer
[    if the byte at the data pointer is zero then instead of moving the instruction pointer forward to the next command jump it forward to the command after the matching command
]
"""
        let output = try! Parser.parse(input)
        XCTAssertEqual(String(output), "><+-.,[]")
    }

    func testProgram() {
        let chars: Array<Character> = [">", "<", "+", "-", ".", ",", "[", "]"]
        let output = try! Parser.program(chars)
        XCTAssertEqual(output, [.ptrIncr, .ptrDec, .incr, .decr, .output, .input, .jmpOpen, .jmpClose])
    }
}

//
//  CliTests.swift
//  FuckerTests
//
//  Created by Maddie Schipper on 3/13/18.
//

import XCTest
@testable import FuckerCore

class CliTests: XCTestCase {
    func testInput() {
        let input = ["/path/to/executable", "file://./Example/hello_world.bf", "--foo", "bar"]
        let output = Cli.parseArguments(input)
        XCTAssertEqual(output.unnamed, ["/path/to/executable", "file://./Example/hello_world.bf"])
        XCTAssertEqual(output.named, ["--foo": "bar"])
    }
}

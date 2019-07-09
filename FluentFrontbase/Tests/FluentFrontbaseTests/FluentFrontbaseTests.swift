import XCTest
@testable import FluentFrontbase

final class FluentFrontbaseTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FluentFrontbase().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

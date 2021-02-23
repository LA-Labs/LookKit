import XCTest
@testable import LookKit_Package

final class LookKit_PackageTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LookKit_Package().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

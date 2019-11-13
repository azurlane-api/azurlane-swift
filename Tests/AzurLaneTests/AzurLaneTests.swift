import XCTest
@testable import AzurLane

final class AzurLaneTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(try AzurLane().test(), "Prinz Eugen")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

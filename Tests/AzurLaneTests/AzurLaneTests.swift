import XCTest
@testable import AzurLane

final class AzurLaneTests: XCTestCase {
    let azurlane = AzurLane()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        let expectation = self.expectation(description: #function)
        var res: ShipResponse?
        var err: APIError?

        azurlane.getShipBy(name: "Prinz Eugen") { (result: Result<ShipResponse, APIError>) in
            switch result {
                case .success(let response):
                    res = response
                case .failure(let error):
                    err = error
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)

        // print(res)
        // print(err)

        XCTAssertEqual(res?.ship.names.en, "Prinz Eugen")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

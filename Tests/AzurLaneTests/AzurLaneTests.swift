import XCTest
@testable import AzurLane

final class AzurLaneTests: XCTestCase {
    let azurlane = AzurLane(Options(token: ""))

    func testGetShipByName() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        let expectation = self.expectation(description: #function)
        var res: ShipResponse?

        azurlane.getShipBy(name: "Prinz Eugen") { (result: Result<ShipResponse, AzurLaneAPIError>) in
            switch result {
                case .success(let response):
                    res = response
                case .failure(let error):
                    print(error)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 35) // 35 seconds because heroku puts the api to sleep when it's not being used
        XCTAssertEqual(res?.ship.names.en, "Prinz Eugen")
    }

    func testGetShips() throws {

        let expectation = self.expectation(description: #function)
        var res: ShipsResponse?

        azurlane.getShips(from: .RARITY, with: "Super Rare") { (result: Result<ShipsResponse, AzurLaneAPIError>) in
            switch result {
            case .success(let response):
                res = response
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 35)
        XCTAssertEqual(res?.ships.first, SmallShip(id: "002", name: "Trial Bullin MKII"))
    }

    static var allTests = [
        ("testGetShipByName", testGetShipByName),
        ("testGetShips", testGetShips),
    ]
}

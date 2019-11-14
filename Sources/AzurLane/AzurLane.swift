import Foundation

public enum Category: String {
    case RARITY = "rarity"
    case TYPE = "type"
    case AFFILIATION = "affiliation"
}

public struct AzurLane {
    private let client: Client
    private let userAgent = "azurlane-swift/v0.0.1 (https://github.com/azurlane-api/azurlane-swift)"

    init(_ userAgent: String? = nil) {
        if let ua = userAgent {
            self.client = Client(ua)
        } else {
            self.client = Client(self.userAgent)
        }
    }

    func getShipBy(name: String, result: @escaping (Result<ShipResponse, AzurLaneAPIError>) -> Void) {
        client.fetchResource(.shipByName, params: [URLQueryItem(name: "name", value: name)], completion: result)
    }

    func getShipBy(id: String, result: @escaping (Result<ShipResponse, AzurLaneAPIError>) -> Void) {
        client.fetchResource(.shipByID, params: [URLQueryItem(name: "id", value: id)], completion: result)
    }

    func getShips(from category: Category, with value: String, result: @escaping (Result<ShipsResponse, AzurLaneAPIError>) -> Void) {
        client.fetchResource(.ships, params: [URLQueryItem(name: "orderBy", value: category.rawValue), URLQueryItem(name: category.rawValue, value: value)], completion: result)
    }

    func getBuildInfo(from time: String, result: @escaping (Result<BuildResponse, AzurLaneAPIError>) -> Void) {
        client.fetchResource(.construction, params: [URLQueryItem(name: "time", value: time)], completion: result)
    }

}

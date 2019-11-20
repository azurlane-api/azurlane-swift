import Foundation

public enum Category: String {
    case RARITY = "rarity"
    case TYPE = "type"
    case AFFILIATION = "affiliation"
}

public struct Options {
    public var token: String
    public var userAgent: String

    public init(token: String, userAgent: String = "azurlane-swift/v\(AzurLane.version) (https://github.com/azurlane-api/azurlane-swift)") {
        self.token = token
        self.userAgent = userAgent
    }
}

public struct AzurLane {
    public static let version = "1.2.1"
    private let client: Client

    public init(_ options: Options) {
        self.client = Client(options)
    }

    public func getShipBy(name: String, result: @escaping (Result<ShipResponse, AzurLaneAPIError>) -> Void) {
        client.fetchResource(.shipByName, params: [URLQueryItem(name: "name", value: name)], completion: result)
    }

    public func getShipBy(id: String, result: @escaping (Result<ShipResponse, AzurLaneAPIError>) -> Void) {
        client.fetchResource(.shipByID, params: [URLQueryItem(name: "id", value: id)], completion: result)
    }

    public func getShips(from category: Category, with value: String, result: @escaping (Result<ShipsResponse, AzurLaneAPIError>) -> Void) {
        client.fetchResource(.ships, params: [URLQueryItem(name: "category", value: category.rawValue), URLQueryItem(name: category.rawValue, value: value)], completion: result)
    }

    public func getBuildInfo(from time: String, result: @escaping (Result<BuildResponse, AzurLaneAPIError>) -> Void) {
        client.fetchResource(.construction, params: [URLQueryItem(name: "time", value: time)], completion: result)
    }

}

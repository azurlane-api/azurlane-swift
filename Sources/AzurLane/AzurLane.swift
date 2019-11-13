import Cheetah

struct Ship: Codable {
    var name: String
}

public struct AzurLane {
    let decoder = JSONDecoder()
    var userAgent: String

    public init(_ ua: String? = nil) {
        userAgent = ua ?? "azurlane-swift/v0.0.1 (https://github.com/azurlane-api/azurlane-swift)"
    }

    func test() throws -> String {
        let json = "{\"name\": \"Prinz Eugen\"}"
        let ship = try? decoder.decode(Ship.self, from: json)
        return ship?.name ?? ""
    }
}
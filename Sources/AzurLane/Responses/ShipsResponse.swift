public struct SmallShip: Decodable, Equatable {
    public let id: String
    public let name: String
}

public struct ShipsResponse: Decodable {
    public let statusCode: Int
    public let statusMessage: String
    public let message: String
    public let ships: [SmallShip]
}
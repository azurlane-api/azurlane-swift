public struct SmallShip: Codable, Equatable {
    let id: String
    let name: String
}

public struct ShipsResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    let message: String
    let ships: [SmallShip]
}
public struct Construction: Codable {
    public let time: String
    public let wikiUrl: String
    public let ships: [String]
}

public struct BuildResponse: Codable {
    public let statusCode: Int
    public let statusMessage: String
    public let message: String
    public let construction: Construction
}
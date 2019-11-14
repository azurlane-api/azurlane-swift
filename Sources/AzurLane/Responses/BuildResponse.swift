public struct Construction: Codable {
    let time: String
    let wikiUrl: String
    let ships: [String]
}

public struct BuildResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    let message: String
    let construction: Construction
}
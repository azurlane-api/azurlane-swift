public struct ErrorResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    let message: String
    let error: String?
}
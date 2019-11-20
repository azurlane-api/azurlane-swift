public struct ErrorResponse: Decodable {
    public let statusCode: Int
    public let statusMessage: String
    public let message: String
    public let error: String?
}
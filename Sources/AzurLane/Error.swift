public struct AzurLaneAPIError: Error {
    public enum Reason: String, Codable {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case invalidRequest
        case noData
        case decodeError

        public var description: String {
            switch self {
            case .apiError:
                return "The api returned and error"
            case .invalidEndpoint:
                return "Endpoint does not exists"
            case .invalidRequest:
                return "Could not create a request"
            case .invalidResponse:
                return "The api returned an invalid response"
            case .noData:
                return "The api did not return any data"
            case .decodeError:
                return "Failed to decode returned data"
            }
        }
    }

    public let description = "An error occured"
    public let message: String?
    public let reason: Reason

    internal init(reason: Reason, message: String? = "No message provided") {
        self.reason = reason
        self.message = message
    }

}
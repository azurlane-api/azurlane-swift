import Foundation

internal struct Endpoints {

    private let base = URL(string: "https://azurlane-api.herokuapp.com")!

    enum Endpoint: String {
        case ship = "ship"
        case ships = "ships"
        case construction = "build"
    }

    func createURL(_ endpoint: Endpoint, params: Set<URLQueryItem>) -> URL {
        var components = URLComponents(string: "/v2/\(endpoint.rawValue)")!
        components.queryItems = Array(params)
        return components.url(relativeTo: base)!
    }

}
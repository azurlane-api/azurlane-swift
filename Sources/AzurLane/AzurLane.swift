import Cheetah
import Foundation
import NIO
import AsyncHTTPClient

public struct Names: Codable {
    var en: String
    var cn: String
    var jp: String
    var kr: String
}

public struct Ship: Codable {
    var names: Names
}

public struct ShipResponse: Codable {
    var statusCode: Int
    var statusMessage: String
    var message: String
    var ship: Ship
}

public enum APIError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

public struct AzurLane {
    private let endpoints = Endpoints()

    let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
    let decoder = Cheetah.JSONDecoder()
    var userAgent: String

    public init(_ ua: String? = nil) {
        userAgent = ua ?? "azurlane-swift/v0.0.1 (https://github.com/azurlane-api/azurlane-swift)"
    }

    func getShipBy(name: String, completion: @escaping (Result<ShipResponse, APIError>) -> Void) {
        let url = endpoints.createURL(.ship, params: [URLQueryItem(name: "name", value: name)])
        httpClient.get(url: url.absoluteString).whenComplete { result in
            switch result {
            case .failure(var error):
                completion(.failure(.apiError))
            case .success(var response):
                guard 200..<299 ~= response.status.code else {
                    completion(.failure(.invalidResponse))
                    return
                }

                do {
                    let bytes = response.body!.readBytes(length: response.body!.readableBytes)!
                    let data = String(bytes: bytes, encoding: .utf8) ?? ""
                    let values = try self.decoder.decode(ShipResponse.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }
    }

    func getShipBy(id: String, completion: @escaping (Result<ShipResponse, APIError>) -> Void) {
        let url = endpoints.createURL(.ship, params: [URLQueryItem(name: "id", value: id)])
        httpClient.get(url: url.absoluteString).whenComplete { result in
            switch result {
            case .failure(var error):
                completion(.failure(.apiError))
            case .success(var response):
                guard 200..<299 ~= response.status.code else {
                    completion(.failure(.invalidResponse))
                    return
                }

                do {
                    let bytes = response.body!.readBytes(length: response.body!.readableBytes)!
                    let data = String(bytes: bytes, encoding: .utf8) ?? ""
                    let values = try self.decoder.decode(ShipResponse.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }
    }
}

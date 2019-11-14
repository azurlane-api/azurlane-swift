import Foundation
// import Cheetah
import AsyncHTTPClient
import NIOHTTP1

internal struct Client {
    var userAgent = ""
    let endpoints = Endpoints()
    let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
    // Seems like Cheetah.JSONDecoder() has issues decoding the returned json into my structs atm
    let decoder = JSONDecoder()

    init(_ userAgent: String) {
        self.userAgent = userAgent
    }

    enum Resource {
        case shipByName
        case shipByID
        case ships
        case construction
    }

    func fetchResource<T: Decodable>(_ resource: Resource, params: Set<URLQueryItem>, completion: @escaping (Result<T, AzurLaneAPIError>) -> Void) {
        var url: URL
        switch resource {
        case .shipByName, .shipByID:
            url = endpoints.createURL(.ship, params: params)
        case .ships:
            url = endpoints.createURL(.ships, params: params)
        case .construction:
            url = endpoints.createURL(.construction, params: params)
        }

        var headers = HTTPHeaders()
        headers.add(name: "User-Agent", value: self.userAgent)
        guard let request = try? HTTPClient.Request(url: url.absoluteString, method: .GET, headers: headers) else {
            completion(.failure(AzurLaneAPIError(reason: .invalidRequest)))
            return
        }

        httpClient.execute(request: request).whenComplete { result in
            switch result {
            case .failure(_):
                completion(.failure(AzurLaneAPIError(reason: .apiError)))
            case .success(var response):
                do {
                    guard let length = response.body?.readableBytes else {
                        completion(.failure(AzurLaneAPIError(reason: .decodeError)))
                        return
                    }

                    guard let bytes = response.body?.readBytes(length: length) else {
                        completion(.failure(AzurLaneAPIError(reason: .decodeError)))
                        return
                    }

                    guard 200..<299 ~= response.status.code else {
                        let error = try self.decoder.decode(ErrorResponse.self, from: Data(bytes))
                        completion(.failure(AzurLaneAPIError(reason: .invalidResponse, message: error.message)))
                        return
                    }

                    // let data = String(bytes: bytes, encoding: .utf8) ?? ""
                    let values = try self.decoder.decode(T.self, from: Data(bytes))
                    completion(.success(values))
                } catch {
                    completion(.failure(AzurLaneAPIError(reason: .decodeError)))
                }
            }
        }
    }

}

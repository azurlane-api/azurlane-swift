import Foundation
// import Cheetah
import AsyncHTTPClient
import NIOHTTP1

internal struct Client {
    var userAgent = ""
    var token = ""
    let endpoints = Endpoints()
    let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
    // Seems like Cheetah.JSONDecoder() has issues decoding the returned json into my structs atm
    //
    // <compiler-generated>:0: error: undefined reference to '$s7Cheetah11JSONDecoderCMa'
    // <compiler-generated>:0: error: undefined reference to '$s7Cheetah11JSONDecoderCACycfC'
    // /media/pepijn/Data/Projects/Swift/AzurLane/Sources/AzurLane/Client.swift:11: error: undefined reference to '$s7Cheetah11JSONDecoderCMa'
    // /media/pepijn/Data/Projects/Swift/AzurLane/Sources/AzurLane/Client.swift:11: error: undefined reference to '$s7Cheetah11JSONDecoderCACycfC'
    // clang-7: error: linker command failed with exit code 1 (use -v to see invocation)
    // :0: error: link command failed with exit code 1 (use -v to see invocation)
    // [2/3] Linking AzurLanePackageTests.xctest
    //
    // let decoder = Cheetah.JSONDecoder()
    let decoder = JSONDecoder()

    init(_ options: Options) {
        self.userAgent = options.userAgent
        self.token = options.token
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
        headers.add(name: "Authorization", value: self.token)
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
                        completion(.failure(AzurLaneAPIError(reason: .decodeError, message: "Could not read response body length")))
                        return
                    }

                    guard let bytes = response.body?.readBytes(length: length) else {
                        completion(.failure(AzurLaneAPIError(reason: .decodeError, message: "Could not read response body bytes")))
                        return
                    }

                    // guard let data = String(bytes: bytes, encoding: .utf8) else {
                    //     completion(.failure(AzurLaneAPIError(reason: .decodeError, message: "Failed converting bytes to string")))
                    //     return
                    // }

                    guard 200..<299 ~= response.status.code else {
                        let error = try self.decoder.decode(ErrorResponse.self, from: Data(bytes))
                        // let error = try self.decoder.decode(ErrorResponse.self, from: data)
                        completion(.failure(AzurLaneAPIError(reason: .invalidResponse, message: error.message)))
                        return
                    }

                    let values = try self.decoder.decode(T.self, from: Data(bytes))
                    // let values = try self.decoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(AzurLaneAPIError(reason: .decodeError)))
                }
            }
        }
    }

}

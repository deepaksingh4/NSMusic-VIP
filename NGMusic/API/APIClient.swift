//
//  APIClient.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.
//

import Foundation

internal final class ApiClient: ApiClientProtocol {
    static let shared = ApiClient()
    private init() { }

    private var urlSession: URLSession = {
        let session = URLSession.shared
        return session
    }()

    // MARK: - Api service

    func performRequest<T>(route: ApiRouter,
                           responseModel: T.Type,
                           success: @escaping (T) -> Void,
                           failed: @escaping (Error, APIErrorType) -> Void) where T: Decodable {
        do {
            let dataTask = try urlSession.dataTask(with: route.asURLRequest(),
                                                   completionHandler: { data, response, error in
                if let error = error {
                    failed(error, APIErrorType.generalServiceError)
                } else if let data = data,
                         let response = response as? HTTPURLResponse,
                         response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let response = try decoder.decode(T.self, from: data)
                        success(response)
                    } catch {
                        failed(error, APIErrorType.jsonParsingError)
                    }
                }
            })
            dataTask.resume()
        } catch {
            failed(error, APIErrorType.generalServiceError)
        }
    }
}

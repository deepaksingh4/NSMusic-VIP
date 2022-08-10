//
//  APIClientMock.swift
//  NGMusicTests
//
//  Created by Deepak on 06/08/22.
//

import Foundation

@testable import NGMusic

class SearchClientAPIMock: ApiClientProtocol {

    func performRequest<T>(
        route: ApiRouter,
        responseModel: T.Type,
        success: @escaping (T) -> Void,
        failed: @escaping (Error, APIErrorType) -> Void
    ) where T: Decodable {
        do {
            if let path = Bundle(for: SearchClientAPIMock.self).path(forResource: "sample", ofType: "json") {
            let fileUrl = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(T.self, from: data)
            success(response)
            }
        } catch {
            failed(error, APIErrorType.jsonParsingError)
        }
    }
}

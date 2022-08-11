//
//  APIClientProtocol.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.
//

import Foundation

protocol ApiClientProtocol {
    func performRequest<T>(
        route: ApiRouter,
        responseModel: T.Type,
        success: @escaping (T) -> Void,
        failed: @escaping (Error, APIErrorType) -> Void) where T: Decodable
}

protocol ApiServiceProtocol {
    var apiClient: ApiClientProtocol {get}
}

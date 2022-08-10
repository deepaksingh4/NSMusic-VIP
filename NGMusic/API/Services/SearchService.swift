//
//  SearchService.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.
//

import Foundation

typealias FailureCompletion = (Error, APIErrorType) -> Void

protocol MusicServiceProtocol: ApiServiceProtocol {
    func searchMovie(query: String,
                     entity: String,
                     success: @escaping (SearchResultResponseModel) -> Void,
                     failure: @escaping(FailureCompletion))
}

class MusicService: MusicServiceProtocol {

    let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol = ApiClient.shared) {
        self.apiClient = apiClient
    }

    func searchMovie(query: String,
                     entity: String,
                     success: @escaping (SearchResultResponseModel) -> Void,
                     failure: @escaping(FailureCompletion)) {
        apiClient.performRequest(route: .searchMusic(term: query, entity: entity),
                              responseModel: SearchResultResponseModel.self,
                              success: success,
                              failed: failure)
    }
}

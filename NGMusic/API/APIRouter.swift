//
//  APIRouter.swift
//  NGMusic
//
//  Created by Deepak on 04/08/22.
//

import Foundation

internal enum ApiRouter {
    case searchMusic(term: String, entity: String)
}

extension ApiRouter {

    var method: String {
        switch self {
        case .searchMusic:
            return "get"
        }
    }

    var path: String {
        switch self {
        case .searchMusic:
            return ApiEndpoints.SearchPath.musicSearch
        }
    }

    var parameters: [String: Any] {
        switch self {
        case .searchMusic(let term, let entity):
            return [ApiParameters.Search.term: term,
                    ApiParameters.Search.entity: entity]
        }
    }

    func asURLRequest() throws -> URLRequest {

        var urlRequest: URLRequest
        guard let url = URL(string: ApiEndpoints.BaseURL.itunesBaseUrl) else {
            throw URLRequestError.invalidURL
        }

        // Create urlRequest
        urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData

        if var urlComponents = URLComponents(
            url: urlRequest.url!,
            resolvingAgainstBaseURL: false),
           !parameters.isEmpty {
            let encodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + prepareQuery(parameters)
            urlComponents.percentEncodedQuery = encodedQuery
            urlRequest.url = urlComponents.url
        }

        // Set max timeout time
        urlRequest.timeoutInterval = ApiParameters.requestTimeOut
        return urlRequest
    }

    private func prepareQuery(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]
            components.append((escape(key), escape("\(value ?? "")")))
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    private func escape(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? string
    }
}

//
//  APIErrors.swift
//  NGMusic
//
//  Created by Deepak on 04/08/22.
//

import Foundation

enum URLRequestError: Error {
    case invalidURL
}

internal enum APIErrorType: Error {
    case generalServiceError
    case badRequestError
    case unauthorisedError
    case serviceUnavailable
    case jsonParsingError
}

internal enum StatusCodes: Int {
    // MARK: - Client errors
    case code400BadRequest = 400
    case code401Unauthorised = 401
    case code403Forbidden = 403
    case code404NotFound = 404

    // MARK: - Server errors
    case code500InternalServerError = 500
    case code501NotImplemented = 501
    case code502BadGateway = 502
    case code503ServiceUnavailable = 503

    var code: Int {
        return rawValue
    }

    static func apiErrorType(_ statusCode: Int) -> APIErrorType {
        switch statusCode {
        case StatusCodes.code400BadRequest.code:
            return APIErrorType.badRequestError
        case StatusCodes.code401Unauthorised.code:
            return APIErrorType.unauthorisedError
        case StatusCodes.code500InternalServerError.code:
            return APIErrorType.serviceUnavailable
        default:
            return APIErrorType.generalServiceError
        }
    }
}

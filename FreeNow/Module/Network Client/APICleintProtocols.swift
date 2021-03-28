//
//  NetworkClient.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/27/21.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

protocol RequestProtocol {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
}

protocol Model: Codable {}

protocol APICleintProtocol {
    func send<ResponsType>(request: RequestProtocol, compeletion: @escaping (Result<ResponsType, Error>) -> Void) where ResponsType: Model
}

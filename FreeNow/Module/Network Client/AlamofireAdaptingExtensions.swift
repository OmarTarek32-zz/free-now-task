//
//  AlamofireExtensions.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/27/21.
//

import Foundation
import Alamofire

enum AlamofireCustomError: Error {
    case canNotMapRequest
    case canNotDecodeObject
    case unknowen
}

struct AlamofireRequestMapper: URLRequestConvertible {
    
    var request: RequestProtocol
    
    init(_ request: RequestProtocol) {
        self.request = request
    }
    
    func asURLRequest() throws -> URLRequest {
        if let url = URL(string: request.url) {
            var urlRequest = URLRequest(url: url)
            let method = request.method
            urlRequest.httpMethod = method.rawValue
            
            if method == .get {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: request.parameters)
                return urlRequest
            }

            return urlRequest
        }
        throw AlamofireCustomError.canNotMapRequest
    }
}

extension Session {
    func request(_ request: RequestProtocol) -> DataRequest {
        let alamofireRequestMapper = AlamofireRequestMapper(request)
        let mappedRequest = try! alamofireRequestMapper.asURLRequest()
        return self.request(mappedRequest)
    }
}

extension DataRequest {
    @discardableResult
    func responseObject<ResponsType: Model>(compeletion: @escaping (Result<ResponsType, Error>) -> Void) -> Self {
        
        responseString { response in
            
            switch response.result {
            case .success(let jsonString):
                
                debugPrint(jsonString)
                guard let jsonData = jsonString.data(using: .utf8),
                      let drivers = try? JSONDecoder().decode(ResponsType.self, from: jsonData)
                else {
                    compeletion(Result.failure(AlamofireCustomError.canNotDecodeObject))
                    return
                }
                compeletion(Result.success(drivers))
                
            case .failure(let error):
                
                compeletion(Result.failure(error))
                
            }
        }
    }
}

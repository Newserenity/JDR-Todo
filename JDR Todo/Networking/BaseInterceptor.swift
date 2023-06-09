//
//  BaseInterceptor.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/07.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

// Custom Interceptor
class BaseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        // Perform any modifications to the request before sending it
        var modifiedRequest = urlRequest
        
        modifiedRequest.headers.add(name: "accept", value: "application/json")
        
        completion(.success(modifiedRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // Handle request retry logic
        // ...
        completion(.doNotRetry)
    }
    
    func didReceive(_ result: Result<Data, AFError>, for request: URLRequest, response: HTTPURLResponse, completion: @escaping (AFResult<Data>) -> Void) {
        switch result {
        case .success(let data):
            completion(.success(data))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}


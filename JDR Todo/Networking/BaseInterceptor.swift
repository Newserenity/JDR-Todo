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

/**
 - Description: 각 메서드 상황에 따른 커스텀 Interceptor
 */
class BaseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        // 커스텀 헤더 추가
        var modifiedRequest = urlRequest
        modifiedRequest.headers.add(name: "accept", value: "application/json")
        
        completion(.success(modifiedRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // Handle request retry logic
        completion(.doNotRetry)
    }
    
    func didReceive(_ result: Result<Data, AFError>, for request: URLRequest, response: HTTPURLResponse, completion: @escaping (AFResult<Data>) -> Void) {
        
        // 에러 처리
        switch result {
        case .success(let data):
            completion(.success(data))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}


//
//  NetworkManager.swift
//  JDR Todo
//
//  Created by Jeff Jeong on 2023/06/06.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

enum NetworkError: Error {
    case invalidResponse
    case requestFailed
    case unknown(err: Error?)
    
    // 에러 정보
    var errorInfo: String {
        switch self {
        case .invalidResponse:  return "유효하지 않는 응답입니다"
        case .requestFailed:    return "요청 실패입니다"
        case .unknown(let err as NSError): return "알 수 없는 에러입니다 : \(err.code)"
        default: return ""
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getTodosRX(page: Int = 1,
                    orderByDate: OrderByDate = .created,
                    orderByIndex: OrderByIndex = .descending,
                    isDone: Status = .both,
                    perPage:Int = 20) -> Observable<[TodoCard]> {
        let interceptor = BaseInterceptor()

        let router = Router.getTodos(page: page,
                                     orderByDate: orderByDate,
                                     orderByIndex: orderByIndex,
                                     isDone: isDone,
                                     perPage: perPage)
        
        return RxAlamofire
            .request(router, interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .data() // Observable<Data>
            .decode(type: ListDataResponse<Todo>.self, decoder: JSONDecoder()) //
            .compactMap { $0.data }
            .map{ $0.map{ TodoCard($0) }
            }
            .catch { err in
                if err is DecodingError {
                    throw NetworkError.invalidResponse
                }
                throw NetworkError.unknown(err: err)
            }
    }
}


//func fetchTodos() -> Observable<[Todo]>{
//    
//    let urlString = "https://phplaravel-574671-2962113.cloudwaysapps.com/api/v2/todos?page=1&filter=created_at&order_by=desc&per_page=10"
//    
//    let url = URL(string: urlString)!
//    
//    var urlRequest = URLRequest(url: url)
//    urlRequest.httpMethod = "GET"
//    urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
//    
//    //NSObject.rx
//    return URLSession
//        .shared
//        .rx
//        .data(request: urlRequest) // Observable<Data>
//        .decode(type: ListDataResponse<Todo>.self, decoder: JSONDecoder())// Observable<TodolistData>
//        .compactMap{ $0.data } // Observable<[Todo]>
//}




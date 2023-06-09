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

final class NetworkManager {
    
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
    
    static let shared = NetworkManager()
    
    
    func fetchTodos() -> Observable<[Todo]>{
        
        let urlString = "https://phplaravel-574671-2962113.cloudwaysapps.com/api/v2/todos?page=1&filter=created_at&order_by=desc&per_page=10"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        
        //NSObject.rx
        return URLSession
            .shared
            .rx
            .data(request: urlRequest) // Observable<Data>
            .decode(type: ListDataResponse<Todo>.self, decoder: JSONDecoder())// Observable<TodolistData>
            .compactMap{ $0.data } // Observable<[Todo]>
        
        // json -> Swift : de code
        // swift -> json : en code
    }
    
    
    
    func getTodosRX() -> Observable<[TodoCard]> {
        let interceptor = BaseInterceptor()
        let session = Session(interceptor: interceptor)

        let router = Router.getTodos(page: 1,
                                           filter: "created_at",
                                           orderBy: .descending,
                                           isDone: .both,
                                           perPage: 20)
        return RxAlamofire
            .request(router, interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .data() // Observable<Data>
            .decode(type: [Todo].self, decoder: JSONDecoder()) //
//            .decode(type: ListDataResponse<Todo>.self, decoder: JSONDecoder()) // Observable<ListDataResponse<Todo>>
//            .compactMap{ $0.data } // Observable<[Todo]>
            .map{ todos in
                return todos.map{ TodoCard($0) }
            }
            .catch { err in
                if err is DecodingError {
                    print(#fileID, #function, #line, "- ")
                    throw NetworkError.invalidResponse
                }
                print(#fileID, #function, #line, "- ")
                throw NetworkError.unknown(err: err)
            }
//            .catchAndReturn([])
    }
    
//    
//    
//    func getTodosRX() -> Observable<[TodoCard]> {
//        let interceptor = CustomInterceptor()
//        let session = Session(interceptor: interceptor)
//
//        let router = Router.getTodos(page: 1,
//                                           filter: "created_at",
//                                           orderBy: .descending,
//                                           isDone: .both,
//                                           perPage: 20)
//        return RxAlamofire
//            .request(router, interceptor: interceptor)
//            .validate(statusCode: 200..<300)
//            .data() // Observable<Data>
//            .decode(type: [Todo].self, decoder: JSONDecoder()) // Observable<[Todo]>
//            .map{ todos in
//                return todos.map{ TodoCard($0) }
//            }
//            .catch { err in
//                if err is DecodingError {
//                    throw NetworkError.invalidResponse
//                }
//                throw NetworkError.unknown(err: err)
//            }
//    }
    
    
//    func fetchTodos() -> Observable<[Todo]>{
//        // Interceptor + URLHTTPResponse + Validation + JSON
//        let adapter = // Some RequestAdapter
//        let retrier = // Some RequestRetrier
//        let interceptor = Interceptor(adapter: adapter, retrier: retrier)
//        _ = session.rx.request(.get, stringURL)
//            .validate()
//            .validate(contentType: ["text/json"])
//            .responseJSON()
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
//        ```
//    }
    
    // Example usage
//    func getUsers() -> Observable<[User]> {
//        let interceptor = CustomInterceptor()
//        let session = Session(interceptor: interceptor)
//        
//        return RxAlamofire
//            .request(.get, try Router.getUsers.asURLRequest(), interceptor: interceptor, session: session)
//            .validate(statusCode: 200..<300)
//            .data()
//            .flatMap { data -> Observable<[User]> in
//                guard let users = try? JSONDecoder().decode([User].self, from: data) else {
//                    return Observable.error(NetworkError.invalidResponse)
//                }
//                return Observable.just(users)
//            }
//    }
//
//    func getUser(id: Int) -> Observable<User> {
//        let interceptor = CustomInterceptor()
//        let session = Session(interceptor: interceptor)
//        
//        return RxAlamofire
//            .request(.get, try Router.getUser(id: id).asURLRequest(), interceptor: interceptor, session: session)
//            .validate(statusCode: 200..<300)
//            .data()
//            .flatMap { data -> Observable<User> in
//                guard let user = try? JSONDecoder().decode(User.self, from: data) else {
//                    return Observable.error(NetworkError.invalidResponse)
//                }
//                return Observable.just(user)
//            }
//    }
    
    
}

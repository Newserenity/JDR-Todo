//
//  Router.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/07.
//

import Foundation
import Alamofire

/**
 * - Description: 라우터를 미리 enum 형식으로 만들어 놓음
 */
enum Router: URLRequestConvertible {
    
    
    case getTodos(page: Int,
                  orderByDate: OrderByDate = .created,
                  orderByIndex: OrderByIndex = .descending,
                  isDone: Status = .both,
                  perPage: Int)
    case getSearch(query: String,
                   orderByDate: OrderByDate = .created,
                   orderByIndex: OrderByIndex = .descending,
                   page:Int,
                   perPage: Int,
                   isDone: Status = .both)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTodos: return .get
        case .getSearch: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getTodos: return "/todos"
        case .getSearch: return "/todos/search"
        }
    }
    
    var parameters: [String:String]? {
        switch self {
        case let .getTodos(page, orderByDate, orderByIndex, isDone, perPage):
            return [
                "page": String(page),
                "filter": orderByDate.rawValue,
                "order_by": orderByIndex.rawValue,
                "per_page": String(perPage),
                "is_done": isDone.rawValue,
            ]
        case let .getSearch(query, orderByDate, orderByIndex, page, perPage, isDone):
            return [
                "query": query,
                "filter": orderByDate.rawValue,
                "order_by": orderByIndex.rawValue,
                "page": String(page),
                "per_page": String(perPage),
                "is_done": isDone.rawValue,
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        // Set parameters to the request if needed
        if let parameters = parameters {
            switch method {
            case .get:
                request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
            case .post:
                request = try JSONParameterEncoder().encode(parameters, into: request)
            // Add cases for other HTTP methods if necessary
            default:
                break
            }
        }
        
        return request
    }
}

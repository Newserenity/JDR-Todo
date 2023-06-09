//
//  Router.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/07.
//

import Foundation
import Alamofire

enum OrderByIndex: String {
    case ascending = "asc"
    case descending = "desc"
}

enum Status: String {
    case both = ""
    case inProgress = "false"
    case finished = "true"
}

enum OrderByDate: String {
    case created = "created_at"
    case updated = "updated_at"
}

enum Router: URLRequestConvertible {
    case getTodos(page: Int,
                  orderByDate: OrderByDate = .created,
                  orderByIndex: OrderByIndex = .descending,
                  isDone: Status = .both,
                  perPage: Int)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTodos: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getTodos: return "/todos"
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
            
//        default: return nil
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

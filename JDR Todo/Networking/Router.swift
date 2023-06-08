//
//  Router.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/07.
//

import Foundation
import Alamofire

enum OrderBy: String {
    case ascending = "asc"
    case descending = "desc"
}

enum Status: String {
    case both = ""
    case inProgress = "false"
    case finished = "true"
}

enum Router: URLRequestConvertible {
    case getTodos(page: Int, filter: String, orderBy: OrderBy = .descending, isDone: Status = .both, perPage: Int)
    
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
        case let .getTodos(page, filter, orderBy, isDone, perPage):
            return [
                "page": String(page),
                "filter": filter,
                "order_by": orderBy.rawValue,
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
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        }
        
        return request
    }
}

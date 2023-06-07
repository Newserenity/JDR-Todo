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

final class NetworkManager {
    
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
    
    
}

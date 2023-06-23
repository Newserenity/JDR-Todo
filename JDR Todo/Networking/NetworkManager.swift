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

/**
 * - Description: 패칭로직 모음
 */
final class NetworkManager {
    
    static let shared = NetworkManager()
    
    /**
     * - Description : todolist 전체 를 받아오기 위한 위한 함수
     *
     * - Parameter :
     *  `page`  현재 위치한 페이지 (기본값 : 1페이지)
     *
     *  `orderByDate` 생성일, 수정일 기준 설정 (기본값 : 생성일)
     *
     *  `orderByIndex` 오름차순, 내림차순 설정  (기본값 : 생성일)
     *
     *  `isDone` 완료여부 설정 (기본값 : 둘다)
     *
     *  `perPage` 페이지당 카드 갯수 (기본값 : 20)
     */
    func getTodos(page: Int = 1,
                  orderByDate: OrderByDate = .created,
                  orderByIndex: OrderByIndex = .descending,
                  isDone: Status = .both,
                  perPage:Int = 20) -> Observable<[TodoCardModel]> {
        let interceptor = BaseInterceptor()
        
        let router = Router.getTodos(page: page,
                                     orderByDate: orderByDate,
                                     orderByIndex: orderByIndex,
                                     isDone: isDone,
                                     perPage: perPage)
        
        return RxAlamofire
            .request(router, interceptor: interceptor)
            .validate()
            .responseData()
            .map { (httpUrlRes, data) -> Data in
                print(httpUrlRes.statusCode)
                
                if httpUrlRes.statusCode == 204{
                    throw NetworkError.noContent
                }
                return data
            }
            .decode(type: ListDataResponse<Todo>.self, decoder: JSONDecoder())
            .compactMap { $0.data }
            .map{ $0.map{ TodoCardModel($0) } }
            .catch { err in
                if err is DecodingError {
                    throw NetworkError.invalidResponse
                }
                if err is NetworkError {
                    throw err
                }
                throw NetworkError.unknown(err: err)
            }
    }
    
    /**
     * - Description : 특정 검색어로 todolist 를 필터링 결과를 받아오기 위한 위한 함수
     *
     * - Parameter :
     *  `query`  검색어 쿼리
     *
     *  `orderByDate` 생성일, 수정일 기준 설정 (기본값 : 생성일)
     *
     *  `orderByIndex` 오름차순, 내림차순 설정  (기본값 : 생성일)
     *
     *  `page` 현재 위치한 페이지 (기본값 : 1페이지)
     *
     *  `perPage` 페이지당 카드 갯수 (기본값 : 20)
     *
     *  `isDone` 완료여부 설정 (기본값 : 둘다)
     */
    func todoFilter(query: String,
                    orderByDate: OrderByDate = .created,
                    orderByIndex: OrderByIndex = .descending,
                    page: Int = 1,
                    perPage: Int = 20,
                    isDone: Status = .both) -> Observable<[TodoCardModel]> {
        let interceptor = BaseInterceptor()
        
        let router = Router.getSearch(query: query,
                                      orderByDate: orderByDate,
                                      orderByIndex: orderByIndex,
                                      page: page,
                                      perPage: perPage,
                                      isDone: isDone)
        
        
        
        return RxAlamofire
            .request(router, interceptor: interceptor)
            .validate()
            .responseData()
            .map { (httpUrlRes, data) -> Data in
                print(httpUrlRes.statusCode)
                
                if httpUrlRes.statusCode == 204{
                    throw NetworkError.noContent
                }
                return data
            }
            .decode(type: ListDataResponse<Todo>.self, decoder: JSONDecoder())
            .compactMap { $0.data }
            .map{ $0.map{ TodoCardModel($0) } }
            .catch { err in
                if err is DecodingError {
                    throw NetworkError.invalidResponse
                }
                if err is NetworkError {
                    throw err
                }
                throw NetworkError.unknown(err: err)
            }
    }
}




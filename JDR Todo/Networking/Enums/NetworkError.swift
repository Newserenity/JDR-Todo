//
//  NetworkError.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/12.
//

import Foundation

/**
 * - Description: 에러타입을 구분하기 위한 enum
 *
 *  `invalidResponse`의 경우  서버의 응답이 본 앱의 엔티티와 맞지 않음
 *
 *  `requestFailed`의 경우 오프라인등 상황에 서버로 요청을 보낼 수 없음
 *
 *  `unknown`의 경우  이 enum애서 정의 하고 있지 않는 에러
 */
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

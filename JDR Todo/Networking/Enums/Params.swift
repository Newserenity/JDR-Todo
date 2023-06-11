//
//  Params.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/12.
//

import Foundation

/**
 * - Description : 쿼리파람에 사용하는 enum값 모음
 */
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

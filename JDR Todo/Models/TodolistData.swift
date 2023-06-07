//
//  TodolistData.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/02.
//

import Foundation



// MARK: - Welcome
struct ListDataResponse<T : Codable>: Codable {
    let data: [T]?
    let meta: Meta?
    let message: String?
}

// MARK: - Welcome
struct DataResponse<T : Codable>: Codable {
    let data: T?
    let message: String?
}

// MARK: - Welcome
struct TodolistData: Codable {
    let data: [Todo]?
    let meta: Meta?
    let message: String?
}

// MARK: - Datum
struct Todo: Codable {
    let id: Int?
    let title: String?
    let isDone: Bool?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case isDone = "is_done"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let currentPage, from, lastPage, perPage: Int?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case perPage = "per_page"
        case to, total
    }
}

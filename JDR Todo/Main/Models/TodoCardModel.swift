//
//  TodoCardModel.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/12.
//

import Foundation

struct TodoCardModel {
    var title: String
    var index: String
    var lastModifiedDate: String
    var createdDate: String
    var status: Bool
    var statusInfo: String {
        return status ? "✅ Finished" : "⌛️ In Progress"
    }
    
    init(_ entity: Todo) {
        
        self.title = entity.title ?? ""
        self.index = "\(entity.id ?? 0)"
        self.lastModifiedDate =  Date.makeDateString(original: entity.updatedAt ?? "") ?? ""
        self.createdDate =  Date.makeDateString(original: entity.createdAt ?? "") ?? ""
        self.status = entity.isDone ?? false
    }
}

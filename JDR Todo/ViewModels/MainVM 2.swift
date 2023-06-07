//
//  MainVM.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/04.
//

import Foundation

struct TodoCard {
    var title: String
    var index: String
    var lastModifiedDate: String
    var createdDate: String
    var status: String
}

final class TodoCardModel {
    static var share = TodoCardModel()
    
    var todoCards: [TodoCard] = [
        TodoCard(title: "Rx문서보기", index: "#91634", lastModifiedDate: "2023/06/01 12:30 MON", createdDate: "2023/06/01 12:30 MON", status: "⌛️ In Progress"),
        TodoCard(title: "수박 사오기", index: "#84512", lastModifiedDate: "2023/06/02 15:30 TUE", createdDate: "2023/06/01 12:30 MON", status: "⌛️ In Progress"),
        TodoCard(title: "청소하기", index: "#44234", lastModifiedDate: "2023/06/01 12:30 MON", createdDate: "2023/06/01 12:30 MON", status: "⌛️ In Progress"),
        TodoCard(title: "정대리 상담", index: "#95513", lastModifiedDate: "2023/06/01 12:30 MON", createdDate: "2023/06/01 12:30 MON", status: "⌛️ In Progress"),
        TodoCard(title: "투두리스트 만들기", index: "#23998", lastModifiedDate: "2023/06/01 12:30 MON", createdDate: "2023/06/01 12:30 MON", status: "✅ Finished"),
        TodoCard(title: "테스트 테스트", index: "#23998", lastModifiedDate: "2023/06/01 12:30 MON", createdDate: "2023/06/01 12:30 MON", status: "✅ Finished"),
        TodoCard(title: "으아아악", index: "#23998", lastModifiedDate: "2023/06/01 12:30 MON", createdDate: "2023/06/01 12:30 MON", status: "✅ Finished"),
    ]
}

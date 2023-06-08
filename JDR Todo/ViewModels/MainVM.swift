//
//  MainVM.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/04.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

struct TodoCard {
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
        
        let dateString = entity.updatedAt ?? ""
        
        let modifiedDate = Date.makeDateString(original: dateString) ?? ""
        
        self.lastModifiedDate = modifiedDate
        self.createdDate = entity.createdAt ?? ""
        self.status = entity.isDone ?? false
    }
    
}

//
final class TodoCardViewModel {
    static var share = TodoCardViewModel()
    
    var todoCards = BehaviorRelay<[TodoCard]>(value: [])
    
    var disposeBag = DisposeBag()
    
    init(){
        print(#fileID, #function, #line, "- ")
        
        NetworkManager.shared
            .fetchTodos() // Observable<[Todo]>
//            .getTodosRX()
            .map{ fetchedTodos in
                return fetchedTodos.map{ TodoCard($0) }
            } // Observable<[TodoCard]>
            .bind(onNext: todoCards.accept(_:))
            .disposed(by: disposeBag)
        
    }
}

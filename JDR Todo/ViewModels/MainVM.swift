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
        self.lastModifiedDate =  Date.makeDateString(original: entity.updatedAt ?? "") ?? ""
        self.createdDate =  Date.makeDateString(original: entity.createdAt ?? "") ?? ""
        self.status = entity.isDone ?? false
    }
}

//
final class TodoCardViewModel {
    static var share = TodoCardViewModel()
    
    var todoCards = BehaviorRelay<[TodoCard]>(value: [])
    
    var errEvent = PublishRelay<Error>()
    
    var disposeBag = DisposeBag()
    
    init(){
        
        NetworkManager.shared
            .getTodosRX()
            .subscribe(onNext: todoCards.accept(_:),
                       onError: errEvent.accept(_:))
            .disposed(by: disposeBag)
    }
}

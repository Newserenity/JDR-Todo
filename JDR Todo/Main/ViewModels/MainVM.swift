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

/**
 *## 클래스 설명: 메인화면에 대한 ViewModel을 구성, `todoCards`란 BehaviorRelay을 이용하여 Main화면에 대한 정보를 변경해줌
 */
final class MainVM {
    static var share = MainVM()
    
    var todoCards = BehaviorRelay<[TodoCardModel]>(value: [])
    var errEvent = PublishRelay<Error>()
    var textOb = BehaviorRelay<String>(value: "")
    
    var disposeBag = DisposeBag()
    
    init(){
        
        textOb
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .flatMapLatest { text in
                if text.isEmpty {
                    return NetworkManager.shared.getTodos()
                } else {
                    return NetworkManager.shared.todoFilter(query: text)
                }
            }
            .catch { error in
                self.errEvent.accept(error)
                return Observable.just([])
            }
            .bind(to: todoCards)
            .disposed(by: disposeBag)
    }
}

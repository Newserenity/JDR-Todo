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
    
    var disposeBag = DisposeBag()
    
    init(){
        
        NetworkManager.shared
            .getTodos()
            .subscribe(onNext: todoCards.accept(_:),
                       onError: errEvent.accept(_:))
            .disposed(by: disposeBag)
    }
}

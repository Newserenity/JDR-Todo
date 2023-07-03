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
    var currentPage = BehaviorRelay<Int>(value: 1)
    var isFetching = BehaviorRelay<Bool>(value: false)
    
    var disposeBag = DisposeBag()
    
    init(){
        
        // 검색 api
        textOb
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .filter{ $0.count > 0 }
            .flatMap{
                return NetworkManager.shared.todoFilter(query: $0)
                    .catch { error in
                        self.errEvent.accept(error)
                        return Observable.just([])
                    }
            }
            .bind(to: todoCards)
            .disposed(by: disposeBag)
        
        textOb
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .filter{ $0.count == 0 }
            .flatMap{ _ in
                return NetworkManager.shared.getTodos(page: self.currentPage.value)
                    .catch { error in
                        self.errEvent.accept(error)
                        return Observable.just([])
                    }
            }
            .bind(to: todoCards)
            .disposed(by: disposeBag)
        
    }
    
    func refreshTodos() {
        NetworkManager.shared.getTodos(page: 1)
            .catch { [weak self] error in
                self?.errEvent.accept(error)
                return Observable.just([])
            }
            .bind(to: todoCards)
            .disposed(by: disposeBag)
    }
    
    func fetchNextPage() {
        guard !self.isFetching.value else { return }
        
        self.isFetching.accept(true)
        
        self.currentPage.accept(self.currentPage.value + 1)
        
        NetworkManager.shared.getTodos(page: self.currentPage.value)
            .catch { [weak self] error in
                self?.errEvent.accept(error)
                self?.isFetching.accept(false)
                return Observable.just([])
            }
            .scan(todoCards.value) { (oldTodos, newTodos) in
                print(newTodos)
                return oldTodos + newTodos
            }
            .do(onNext: { [weak self] _ in
                self?.isFetching.accept(false)
            })
            .observe(on: MainScheduler.instance)
            .bind(to: todoCards)
            .disposed(by: disposeBag)
    }
}

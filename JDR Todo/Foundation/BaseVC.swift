//
//  BaseVC.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/12.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

/**
 - Description: 베이스 VC로, 뷰컨트롤러에 사용되는 기본적인 메서드를 담고 있음 (ex. bind, configure...)
 */
class BaseVC: UIViewController {

    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setProperty()
        setLayout()
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navbar hide setting
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // navbar hide setting
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - View Method
    /**
     - Description: RX에 대한 데이터 바인딩 메서드
     - Warning: RX데이터 바인딩만 사용할 것 (프로퍼티나 레이아웃 설정의 경우 다른 메서드 사용)
     ```
     override bindUI() {
       ObservableData.bind(하위뷰.rx.etc)
        .subscribe(...)
     }
     ```
     */
    public func bindUI() {}
    /**
     - Description: UIViewController에 사용될 프로퍼티 설정 메서드
     ```
     override setProperty() {
       view.backgroundColor = .red
     }
     ```
     */
    public func setProperty() {}
    /**
     - Description: UIViewController에 사용될 하위 View에 대한 메서드
     ```
     override setLayout() {
       addSubView(하위뷰)
     }
     ```
     */
    public func setLayout() {}
    /**
     - Description: UIViewController에 addSubView된 UIView들에 대한 오토레이아웃 설정 메서드
     ```
     override setConstraint() {
       하위뷰.snp.makeConstraint {...}
     }
     ```
     */
    public func setConstraint() {}
}

//
//  Utils.swift
//  JDR Todo
//
//  Created by Jeff Jeong on 2023/06/09.
//

import Foundation
import UIKit

/**
 - Description: 자주 사용하는 요소를 메서드로 미리 정의해둠
 */
final class Utils {
    
    static let shared = Utils()
    
    /**
     * - Description : 네트워크 에러메세지와 함꼐 시스템 얼랏창 띄우는 메소드
     *
     * - Parameter :
     *  `parentVC`  얼랏창을 표시할 뷰컨트롤러
     *
     *  `networkErr` NetworkError타입의 에러
     ```
     Utils.shared.presentErrorAlert(parentVC: self, networkErr: networkErr)
     ```
     */
    func presentErrorAlert(parentVC: UIViewController,
                           networkErr: NetworkError,
                           confirmAction: ((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: "에러", message: networkErr.errorInfo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: confirmAction))
        
        parentVC.present(alert, animated: true, completion: nil)
    }
    
}

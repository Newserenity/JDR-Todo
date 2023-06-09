//
//  Utils.swift
//  JDR Todo
//
//  Created by Jeff Jeong on 2023/06/09.
//

import Foundation
import UIKit
final class Utils {
    
    static let shared = Utils()
    
    
    func presentErrorAlert(parentVC: UIViewController,
                           networkErr: NetworkError){
        let alert = UIAlertController(title: "에러", message: networkErr.errorInfo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        parentVC.present(alert, animated: true, completion: nil)
    }
    
}

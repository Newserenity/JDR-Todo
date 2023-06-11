//
//  UIViewController+Ext.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/01.
//

import UIKit

/**
 - Description: UIViewController 의 확장, NavBar숨기기와  미리보기 설정 정의
 */
extension UIViewController {
    
    //MARK: - Custom Method
    /**
     - Description: Navbar 를 숨기기 위한 메소드
     ```
     override func viewDidLoad() {
        super.viewDidLoad()
                
        configNavbar()
        ...
     }
     ```
     */
    func configNavbar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.tintColor = .brown
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

#if DEBUG

import SwiftUI

extension UIViewController {
    private struct VCRepresentable: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
    }
    
    func getPreview() -> some View {
        VCRepresentable(viewController: self)
    }
}

#endif

//
//  ViewController.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/05/28.
//

import UIKit
import Then
import SnapKit

final class MainVC: UIViewController {
    fileprivate let searchBar = SearchBarView()
    fileprivate let todoTabelView = TodoTabelView()
    
    fileprivate lazy var titleLabel = UILabel().then {
//        $0.backgroundColor = .cyan
        $0.text = "Todo List"
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 27, weight: .heavy)
    }
    
    private var config = UIButton.Configuration.filled()
    fileprivate lazy var addButton = UIButton().then {
        $0.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        $0.configuration = .filled()
        config.title = "+"
        config.baseBackgroundColor = .systemOrange
        config.cornerStyle = .capsule
        config.titlePadding = 10
        $0.configuration = self.config
    }
    
    fileprivate lazy var topBarStackView: UIStackView = UIStackView().then {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .horizontal
//        $0.backgroundColor = .systemYellow
    }
    

    // lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configProperty()
        configLayout()
        configNavbar()
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
    
    @objc private func btnPressed() {
        present(UploadVC(), animated: true, completion: nil)
    }
}

// MARK: - Setting Self
extension MainVC {
    // self stored property
    fileprivate func configProperty() {
        self.view.backgroundColor = .white
    }
}

// MARK: - addSubview / autolayout
extension MainVC {
    fileprivate func configLayout() {
        self.view.addSubview(topBarStackView)
        topBarStackView.addSubview(titleLabel)
        topBarStackView.addSubview(addButton)
        self.view.addSubview(searchBar)
        self.view.addSubview(todoTabelView)

        topBarStackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(15)
        }

        addButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(15)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(topBarStackView.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(15)
        }
        
        todoTabelView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(15)
        }

//        starListTV.snp.makeConstraints {
//            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
//            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(10)
//            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
//        }
    }
}

// MARK: - Preview 관련
#if DEBUG

import SwiftUI

struct MainVC_Previews: PreviewProvider {
    static var previews: some View {
        MainVC()
            .getPreview()
    }
}

#endif

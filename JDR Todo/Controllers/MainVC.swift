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
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 27, weight: .heavy)
    }
    
    private var config = UIButton.Configuration.filled()
    fileprivate lazy var addButton = UIButton().then {
        $0.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        $0.configuration = .filled()
        config.title = "+"
        config.baseBackgroundColor = .systemOrange
        config.cornerStyle = .capsule
        config.titlePadding = 10
        $0.configuration = self.config
    }
    
    private var config2 = UIButton.Configuration.filled()
    fileprivate lazy var addButton2 = UIButton().then {
        $0.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        $0.configuration = .filled()
        config2.title = "⚞"
        config2.baseBackgroundColor = .systemOrange
        config2.cornerStyle = .capsule
        config2.titlePadding = 10
        $0.configuration = self.config2
    }
    
    fileprivate lazy var topBarStackView: UIStackView = UIStackView().then {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .horizontal
//        $0.backgroundColor = .systemYellow
    }
    
    fileprivate lazy var btnStackView: UIStackView = UIStackView().then {
        $0.distribution = .fill
        $0.alignment = .center
        $0.axis = .horizontal
//        $0.backgroundColor = .systemYellow
        $0.spacing = 10
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
    
    @objc private func addButtonPressed() {
        present(UploadVC(), animated: true, completion: nil)
    }
    
    @objc private func filterButtonPressed() {
        SearchFilterVC.shared.modalPresentationStyle = .overFullScreen
        present(SearchFilterVC.shared, animated: true, completion: nil)
        
//        SearchFilterVC.shared.presentAsModal()
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
        topBarStackView.addArrangedSubview(titleLabel)
        topBarStackView.addArrangedSubview(btnStackView)
        btnStackView.addArrangedSubview(addButton)
        btnStackView.addArrangedSubview(addButton2)
        self.view.addSubview(searchBar)
        self.view.addSubview(todoTabelView)

        topBarStackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(5)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().inset(15)
        }
            
        btnStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
//            $0.right.equalToSuperview().inset(15)
            $0.height.equalTo(20)
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

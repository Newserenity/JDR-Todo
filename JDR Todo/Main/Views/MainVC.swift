//
//  ViewController.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/05/28.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxRelay
import RxCocoa

/**
 *##화면 명: JDR TODO 메인화면 (TODO카드뷰, 검색, TODO추가 및 삭제)
 */
final class MainVC: BaseVC {
    
    fileprivate let searchBar = SearchBarView()
    fileprivate let todoTabelView = TodoTabelView()
    fileprivate var viewModel: MainVM
    
    var disposeBag = DisposeBag()
    
    fileprivate lazy var titleLabel = UILabel().then {
        $0.text = "Todo List"
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 27, weight: .heavy)
    }
    
    private var addButtonConfig = UIButton.Configuration.filled()
    fileprivate lazy var addButton = UIButton().then {
        $0.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        $0.configuration = .filled()
        addButtonConfig.title = "+"
        addButtonConfig.baseBackgroundColor = .systemOrange
        addButtonConfig.cornerStyle = .capsule
        addButtonConfig.titlePadding = 10
        $0.configuration = self.addButtonConfig
    }
    
    private var filterButtonConfig = UIButton.Configuration.filled()
    fileprivate lazy var filterButton = UIButton().then {
        $0.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        $0.configuration = .filled()
        filterButtonConfig.title = "⚞"
        filterButtonConfig.baseBackgroundColor = .systemOrange
        filterButtonConfig.cornerStyle = .capsule
        filterButtonConfig.titlePadding = 10
        $0.configuration = self.filterButtonConfig
    }
    
    fileprivate lazy var topBarStackView: UIStackView = UIStackView().then {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .horizontal
    }
    
    fileprivate lazy var btnStackView: UIStackView = UIStackView().then {
        $0.distribution = .fill
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    var errorOccured : Bool = false
    
    //MARK: - View Life Cycle
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
    
    override func bindUI() {
        
        searchBar.searchBarTextFiled
            .rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .do(onNext: { _ in self.errorOccured = false })
            .filter{ _ in self.errorOccured == false }
            .bind(to: MainVM.share.textOb)
            .disposed(by: disposeBag)
        
        MainVM.share.todoCards
            .bind(to: todoTabelView.tableView
                .rx
                .items(cellIdentifier: IDENTIFIER.TODO_TV_CELL, cellType: TodoTableViewCell.self)) { index, card, cell in
                    cell.configureData(card)
                }
                .disposed(by: disposeBag)
        
        MainVM.share.errEvent
            .subscribe(onNext: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    
        
    }
    
    override func setProperty() {
        view.backgroundColor = .white
    }
    
    override func setLayout() {
        [topBarStackView, searchBar, todoTabelView].forEach {
            view.addSubview($0)
        }
        
        [titleLabel, btnStackView].forEach {
            topBarStackView.addArrangedSubview($0)
        }
        
        [addButton, filterButton].forEach {
            btnStackView.addArrangedSubview($0)
        }
    }
    
    override func setConstraint() {
        topBarStackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(5)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
            
        btnStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
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
    
    //MARK: - Initalize Method
    init(vm viewModel: MainVM = MainVM()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Action Method
extension MainVC {
    @objc fileprivate func addButtonPressed() {
        present(UploadVC(), animated: true, completion: nil)
    }
    
    @objc fileprivate func filterButtonPressed() {
        SearchFilterVC.shared.modalPresentationStyle = .overFullScreen
        present(SearchFilterVC.shared, animated: true, completion: nil)
    }
}

//MARK: - Custom Method
extension MainVC {
    fileprivate func handleError(_ err: Error) {
        print(#fileID, #function, #line, "- err: \(err)")
        
        if let networkErr : NetworkError = err as? NetworkError {
            switch networkErr {
            case .invalidResponse:
                print(#fileID, #function, #line, "- invalidResponse")
            case .requestFailed:
                print(#fileID, #function, #line, "- requestFailed")
            case .unknown(let err):
                print(#fileID, #function, #line, "- err \(String(describing: err))")
            case .noContent:
                print(#fileID, #function, #line, "- no contents")
            }
            
            Utils.shared.presentErrorAlert(parentVC: self,
                                           networkErr: networkErr, confirmAction: { [weak self] _ in
                self?.errorOccured = true
            })
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

//
//  TodoTableView.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/02.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

/**
 * ##화면 명: 투두리스트 뷰
 */
final class TodoTabelView: BaseView {
    
    var disposeBag = DisposeBag()

    lazy var refreshControl = UIRefreshControl().then {
        $0.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    lazy var tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.delegate = self
        $0.sectionHeaderHeight = 15
    }
    
    fileprivate lazy var intervalView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    //MARK: - View Life Cycle
    override func setProperty() {
//        tableView.delegate = self
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: IDENTIFIER.TODO_TV_CELL)
        tableView.refreshControl = refreshControl
    }
    
    override func setLayout() {
        addSubview(tableView)
    }
    
    override func setConstraint() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func bindUI() {
        MainVM.share.todoCards
            .bind(to: self.tableView
                .rx
                .items(cellIdentifier: IDENTIFIER.TODO_TV_CELL, cellType: TodoTableViewCell.self)) { index, card, cell in
                    cell.configureData(card)
                }
                .disposed(by: disposeBag)
        
        tableView
            .rx
            .didScroll
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let offSetY = self.tableView.contentOffset.y
                let contentHeight = self.tableView.contentSize.height
                
                if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
                    if !MainVM.share.isFetching.value {
                        MainVM.share.fetchNextPage()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func refresh(_ sender: Any) {
            // 여기에 새로고침 동작을 처리하는 로직을 구현합니다.
        
            MainVM.share.refreshTodos()
            
            // 새로고침 완료 후 UI 갱신을 종료합니다.
            refreshControl.endRefreshing()
        }
}



// MARK: - UITableViewDelegate
extension TodoTabelView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 // 셀 높이 값
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // 삭제 작업 수행
            completionHandler(true)
        }
        
        let changeStatusAction = UIContextualAction(style: .normal, title: "Flip Status") { (action, view, completionHandler) in
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, changeStatusAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let detailViewController = UIViewController()
            
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let sceneDelegate = scene.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController?.present(detailViewController, animated: true, completion: nil)
                }
            }
    }
}

extension TodoTabelView: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        
//        if offsetY > contentHeight - scrollView.frame.height {
//            // 스크롤이 맨 아래에 도달하고, 데이터를 불러오고 있지 않은 경우에만 다음 페이지를 가져옵니다.
//            if !MainVM.share.isFetching.value {
//                MainVM.share.fetchNextPage()
//            }
//        }
//    }
}


// MARK: - Preview 관련
#if DEBUG

import SwiftUI

struct TodoTabelView_Previews: PreviewProvider {
    static var previews: some View {
        TodoTabelView()
            .getPreview()
            .previewLayout(.sizeThatFits)
    }
}

#endif

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
    
    let viewModel = MainVM()
    let disposeBag = DisposeBag()
    
    fileprivate lazy var tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.delegate = self
        $0.sectionHeaderHeight = 15
    }
    
    fileprivate lazy var intervalView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    //MARK: - View Life Cycle
    override func bindUI() {
        viewModel.todoCards.bind(to: tableView.rx.items(cellIdentifier: IDENTIFIER.TODO_TV_CELL, cellType: TodoTableViewCell.self)) { index, card, cell in

            cell.configureData(card)
        }
        .disposed(by: disposeBag)
    }
    
    override func setProperty() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: IDENTIFIER.TODO_TV_CELL)
    }
    
    override func setLayout() {
        addSubview(tableView)
    }
    
    override func setConstraint() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
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

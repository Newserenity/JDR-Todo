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

final class TodoTabelView: UIView {
    
    let viewModel = TodoCardViewModel()
    let disposeBag = DisposeBag()
    
    fileprivate lazy var tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.delegate = self
//        $0.dataSource = self
        $0.sectionHeaderHeight = 15
    }
    
    fileprivate lazy var intervalView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configProperty()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setting Self
extension TodoTabelView {
    // self stored property
    fileprivate func configProperty() {
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: IDENTIFIER.TODO_TABLEVIEW_CELL)
        
        viewModel.todoCards.bind(to: tableView.rx.items(cellIdentifier: IDENTIFIER.TODO_TABLEVIEW_CELL, cellType: TodoTableViewCell.self)) { index, card, cell in
            
            cell.ob.onNext(card)
        }
        .disposed(by: disposeBag)
    }
}


//MARK: - UITableViewDataSource 관련
//extension TodoTabelView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return TodoCardModel.share.todoCards.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
//
////        let card = TodoCardModel.share.todoCards[indexPath.row]
////        TodoCardModel.share.configure()
////        cell.createdDate.text = card.createdDate
////        cell.lastModifiedDate.text = card.lastModifiedDate
////        cell.statusLabel.text = card.status
////        cell.titleLabel.text = card.title
////        cell.idLabel.text = card.index
//
//        return cell
//    }
//}

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
            
            let detailViewController = DetailVC()
            
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let sceneDelegate = scene.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController?.present(detailViewController, animated: true, completion: nil)
                }
            }
    }

}

// MARK: - autolayout
extension TodoTabelView {
    fileprivate func configLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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

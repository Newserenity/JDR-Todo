//
//  TodoTableView.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/02.
//

import UIKit
import SnapKit
import Then

final class TodoTabelView: UIView {
    
    var todoArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    fileprivate lazy var tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
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
        self.tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
    }
}


//MARK: - UITableViewDataSource 관련
extension TodoTabelView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TodoTabelView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 // 셀 높이 값
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return 15  // 원하는 간격 높이 값으로 변경
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return intervalView
//    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // 삭제 작업 수행
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
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
        
//        intervalView.snp.makeConstraints {
//            $0.size.equalTo(15)
//        }
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

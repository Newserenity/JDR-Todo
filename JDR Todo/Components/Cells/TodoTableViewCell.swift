//
//  TodoTableViewCell.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/01.
//

import UIKit
import Then
import RxSwift
import RxRelay
import RxCocoa

extension Reactive where Base: TodoTableViewCell {
    var cellData: Binder<TodoCard> {
        return Binder(base,
                      binding: { cell, todoCard in
            cell.createdDate.text = todoCard.createdDate
            cell.lastModifiedDate.text = todoCard.lastModifiedDate
            cell.statusLabel.text = todoCard.statusInfo
            cell.statusLabel.textColor = todoCard.status ? .systemGreen : .systemBrown
            cell.titleLabel.text = todoCard.title
            cell.idLabel.text = todoCard.index
        })
    }
}

final class TodoTableViewCell: UITableViewCell {
    
    var ob: AnyObserver<TodoCard>
    let disposeBag = DisposeBag()
    
    fileprivate lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalCentering
    }
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .left
    }
    
    fileprivate lazy var dateStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 5
    }
    
    lazy var createdDate = UILabel().then {
        $0.textColor = .systemGray2
        $0.font = .systemFont(ofSize: 10.5, weight: .medium)
        $0.textAlignment = .left
    }
    
    lazy var lastModifiedDate = UILabel().then {
        $0.textColor = .systemGray2
        $0.font = .systemFont(ofSize: 10.5, weight: .medium)
        $0.textAlignment = .left
    }
    
    fileprivate lazy var bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .bottom
        $0.distribution = .equalCentering
    }
    
    fileprivate lazy var topStackView = UIStackView().then {
        $0.spacing = 8
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalCentering
    }
    
    lazy var statusLabel = UILabel().then {
        $0.textColor = .systemBrown
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .left
    }
    
    lazy var idLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let data = PublishSubject<TodoCard>()
        ob = data.asObserver()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configLayout()
        
        data.observe(on: MainScheduler.instance)
            .bind(to: self.rx.cellData)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
}


// MARK: - Autolayout 관련
extension TodoTableViewCell {
    fileprivate func configLayout() {
       
        self.contentView.clipsToBounds = true

        contentView.layer.cornerRadius = 10
        self.contentView.layer.backgroundColor = UIColor.systemGray6.cgColor
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()

        self.selectionStyle = .none

        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(topStackView)
        verticalStackView.addArrangedSubview(bottomStackView)

        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(idLabel)

        bottomStackView.addArrangedSubview(dateStackView)
        bottomStackView.addArrangedSubview(statusLabel)

        dateStackView.addArrangedSubview(createdDate)
        dateStackView.addArrangedSubview(lastModifiedDate)
        
//        self.contentView.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(12)
//        }
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }


        bottomStackView.snp.makeConstraints {
         $0.horizontalEdges.equalToSuperview()
        }
    }
}


// MARK: - Preview 관련
#if DEBUG

import SwiftUI

struct TodoTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        TodoTableViewCell()
            .getPreview()
            .frame(width: 400, height: 100)
            .previewLayout(.sizeThatFits)

    }
}

#endif

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


//extension Reactive where Base: TodoTableViewCell {
//    var cellData: Binder<TodoCardModel> {
//        return Binder(base,
//                      binding: { cell, todoCard in
//            cell.createdDate.text = todoCard.createdDate
//            cell.lastModifiedDate.text = todoCard.lastModifiedDate
//            cell.statusLabel.text = todoCard.statusInfo
//            cell.statusLabel.textColor = todoCard.status ? .systemGreen : .systemBrown
//            cell.titleLabel.text = todoCard.title
//            cell.idLabel.text = todoCard.index
//        })
//    }
//}

/**
 * ##화면 명: 단일 투두리스트 셀
 */
final class TodoTableViewCell: BaseTableViewCell {
    
    var disposeBag = DisposeBag()
    var cellData : TodoCardModel? = nil
    
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
    
    
    
    //MARK: - View Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    override func setProperty() {
        self.contentView.clipsToBounds = true

        contentView.layer.cornerRadius = 10
        self.contentView.layer.backgroundColor = UIColor.systemGray6.cgColor
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()

        self.selectionStyle = .none

    }
    
    override func setLayout() {
        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(topStackView)
        verticalStackView.addArrangedSubview(bottomStackView)

        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(idLabel)

        bottomStackView.addArrangedSubview(dateStackView)
        bottomStackView.addArrangedSubview(statusLabel)

        dateStackView.addArrangedSubview(createdDate)
        dateStackView.addArrangedSubview(lastModifiedDate)
    }
    
    override func setConstraint() {
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }


        bottomStackView.snp.makeConstraints {
         $0.horizontalEdges.equalToSuperview()
        }
    }
}

//MARK: - Custom Method
extension TodoTableViewCell {
    func configureData(_ cellData: TodoCardModel){
        self.createdDate.text = cellData.createdDate
        self.lastModifiedDate.text = cellData.lastModifiedDate
        self.statusLabel.text = cellData.statusInfo
        self.statusLabel.textColor = cellData.status ? .systemGreen : .systemBrown
        self.titleLabel.text = cellData.title
        self.idLabel.text = cellData.index
    }
}

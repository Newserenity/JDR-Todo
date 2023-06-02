//
//  TodoTableViewCell.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/01.
//

import UIKit
import Then

final class TodoTableViewCell: UITableViewCell {
    
    fileprivate lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalCentering
    }
    
    fileprivate lazy var titleLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .left
        $0.text = "JDR RxSwift Demo"
        
    }
    
    fileprivate lazy var dateStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 5
    }
    
    fileprivate lazy var createdDate = UILabel().then {
        $0.textColor = .systemGray2
        $0.font = .systemFont(ofSize: 10.5, weight: .medium)
        $0.textAlignment = .left
        $0.text = "2023/06/01 12:30 MON"
        
    }
    
    fileprivate lazy var lastModifiedDate = UILabel().then {
        $0.textColor = .systemGray2
        $0.font = .systemFont(ofSize: 10.5, weight: .medium)
        $0.textAlignment = .left
        $0.text = "2023/07/12 19:15 FRI"
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
    
    fileprivate lazy var statusLabel = UILabel().then {
        $0.textColor = .systemBrown
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .left
        $0.text = "⌛️ In Progress"
    }
    
    fileprivate lazy var idLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.text = "#8267"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configLayout()
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

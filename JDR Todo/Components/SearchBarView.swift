//
//  SearchBarView.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/01.
//

import UIKit
import SnapKit
import Then

final class SearchBarView: UIView {
    
    fileprivate lazy var searchView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 10
    }
    
    fileprivate lazy var searchImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.contentMode = .scaleAspectFit
        UIImageView.appearance().tintColor = .systemGray3
    }
    fileprivate lazy var searchBarTextFiled = UITextField().then {
        $0.placeholder = "Search By Title"
        $0.font = .systemFont(ofSize: 12)
        UITextField.appearance().tintColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configProperty()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // override touchesBegan (키보드 내리기)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBarTextFiled.resignFirstResponder()
    }
}

// MARK: - delegate 관련
extension SearchBarView {
    fileprivate func configProperty() {
        searchBarTextFiled.delegate = self
    }
}

// MARK: - autoLayout 관련
extension SearchBarView {
    fileprivate func configLayout() {
        searchView.addSubview(searchImageView)
        searchView.addSubview(searchBarTextFiled)
        addSubview(searchView)
        
        searchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        searchImageView.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.left.equalTo(searchView.snp.left).offset(18)
            $0.centerY.equalToSuperview()
        }
        
        searchBarTextFiled.snp.makeConstraints {
            $0.left.equalTo(searchImageView.snp.right).offset(10)
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
    }
}

// MARK: - UITextFieldDelegate 관련
extension SearchBarView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchBarTextFiled.resignFirstResponder()
        
        return true
    }
}


// MARK: - Preview 관련
#if DEBUG

import SwiftUI

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
            .getPreview()
            .frame(width: 400, height: 60)
            .previewLayout(.sizeThatFits)
    }
}

#endif

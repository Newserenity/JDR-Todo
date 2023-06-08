//
//  SearchFilter.swift
//  JDR Todo
//
//  Created by Jayden Jang on 2023/06/08.
//

import Foundation
import UIKit

final class SearchFilterVC: UIViewController {
    
    static var shared = SearchFilterVC()
    
    private var dimView = UIView().then {
        $0.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0)
    }
    
    private var popUpView = UIView().then {
        $0.backgroundColor = .white
    }
    
    fileprivate lazy var titleLabel = UILabel().then {
        $0.text = "Set Filters"
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
    }
    
    fileprivate lazy var orderByLabel = UILabel().then {
        $0.text = "Order By"
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    private var descendingButtonConfig = UIButton.Configuration.filled()
    fileprivate lazy var descendingButton = UIButton().then {
        $0.addTarget(self, action: #selector(descendingButtonPressed), for: .touchUpInside)
        $0.configuration = .filled()
        descendingButtonConfig.title = "desc"
        descendingButtonConfig.baseBackgroundColor = .systemOrange
        descendingButtonConfig.cornerStyle = .dynamic
        descendingButtonConfig.titlePadding = 10
        $0.configuration = self.descendingButtonConfig
    }
    
    private var ascendingButtonConfig = UIButton.Configuration.filled()
    fileprivate lazy var ascendingButton = UIButton().then {
        $0.addTarget(self, action: #selector(ascendingButtonPressed), for: .touchUpInside)
        $0.configuration = .filled()
        ascendingButtonConfig.title = "asc"
        ascendingButtonConfig.baseBackgroundColor = .systemGray4
        ascendingButtonConfig.cornerStyle = .dynamic
        ascendingButtonConfig.titlePadding = 10
        $0.configuration = self.ascendingButtonConfig
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navbar hide setting
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        guard let presentingView = self.presentingViewController?.view else {
            return
        }
        
        presentingView.addSubview(dimView)
        
        dimView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.dimView.backgroundColor = .black
            self.dimView.alpha = 0.25
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // navbar hide setting
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha = 0
        } completion: { _ in
            self.dimView.removeFromSuperview()
        }
    }
    
    @objc func descendingButtonPressed() {
        descendingButton.isSelected = true
        ascendingButton.isSelected = false
        
        // 내림차순 버튼이 선택된 상태일 때의 동작 처리
        // ...
        
        descendingButtonConfig.baseBackgroundColor = .systemOrange
        ascendingButtonConfig.baseBackgroundColor = .systemGray4
        descendingButton.configuration = descendingButtonConfig
        ascendingButton.configuration = ascendingButtonConfig
    }

    @objc func ascendingButtonPressed() {
        ascendingButton.isSelected = true
        descendingButton.isSelected = false
        
        // 오름차순 버튼이 선택된 상태일 때의 동작 처리
        // ...
        
        ascendingButtonConfig.baseBackgroundColor = .systemOrange
        descendingButtonConfig.baseBackgroundColor = .systemGray4
        ascendingButton.configuration = ascendingButtonConfig
        descendingButton.configuration = descendingButtonConfig
    }
    
    // Presenting the view controller
      func presentAsModal() {
          let searchFilterVC = SearchFilterVC()
          searchFilterVC.modalPresentationStyle = .custom
//          searchFilterVC.transitioningDelegate = self
          present(searchFilterVC, animated: true, completion: nil)
      }
      
      // Custom transition animation
//      func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//          return SearchFilterTransitionAnimator(isPresenting: true)
//      }
//
//      func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//          return SearchFilterTransitionAnimator(isPresenting: false)
//      }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
}

// MARK: - Setting Self
extension SearchFilterVC {
    // self stored property
    fileprivate func configProperty() {
//        self.view.backgroundColor = .white
    }
}

// MARK: - addSubview / autolayout
extension SearchFilterVC {
    fileprivate func configLayout() {
        
        view.addSubview(popUpView)
        
        popUpView.addSubview(titleLabel)
        popUpView.addSubview(orderByLabel)
        
        btnStackView.addArrangedSubview(ascendingButton)
        btnStackView.addArrangedSubview(descendingButton)
        
        popUpView.addSubview(btnStackView)
        
        popUpView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
        }
        
        orderByLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(13)
        }
        
        btnStackView.snp.makeConstraints {
            $0.top.equalTo(orderByLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }
    }
}


class SearchFilterTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        if isPresenting {
            containerView.addSubview(toViewController.view)
            
            // Set initial frame for the presented view
            let initialFrame = CGRect(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: 300)
            toViewController.view.frame = initialFrame
            
            // Animate the presented view to its final frame
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toViewController.view.frame = containerView.bounds
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        } else {
            // Animate the dismissal of the view controller
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromViewController.view.frame = CGRect(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: 300)
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        }
    }
    
}







// MARK: - Preview 관련
#if DEBUG

import SwiftUI

struct SearchFilterVC_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterVC()
            .getPreview()
    }
}

#endif

//
//  ResultButton.swift
//  Quiz
//
//  Created by dev dfcc on 7/15/25.
//

import UIKit

final class ResultButton: UIButton {
    var resultType: AnswerType = .none {
        didSet {
            isUserInteractionEnabled = true
            showAnimation()
        }
    }
    
    init(resultType: AnswerType = .none) {
        self.resultType = resultType
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ResultButton {
    func setup() {
        isUserInteractionEnabled = false
        contentHorizontalAlignment = .center   // 가운데 정렬 (기본값)
        titleLabel?.font = .boldSystemFont(ofSize: 40)
    }
    
    func showAnimation(){
        setTitle(resultType.icon, for: .normal)
        titleLabel?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)  // 2. 크기를 키운 상태로 시작
     //   titleLabel?.alpha = 0.0

        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.15,
                       initialSpringVelocity: 0.9,
                       options: [],
                       animations: { [weak self] in
            guard let self = self else { return }
            self.titleLabel?.transform = .identity   // 3. 원래 크기로 줄이면서
       //     self.titleLabel?.alpha = 1.0             // 동시에 페이드 인
        }, completion: nil)
    }
}

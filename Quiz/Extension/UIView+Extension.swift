//
//  UIView+Extension.swift
//  Quiz
//
//  Created by dev dfcc on 7/24/25.
//

import UIKit

extension UIView {
    
    func addDashedBorder(to view: UIView, color: UIColor = .black) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor  // 점선 색
        shapeLayer.lineWidth = 2                        // 선 두께
        shapeLayer.lineDashPattern = [4, 2]             // [그리는 길이, 쉬는 길이]
        shapeLayer.fillColor = nil                      // 내부는 투명
        let path = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius)
        shapeLayer.path = path.cgPath
        
        view.layer.addSublayer(shapeLayer)
    }
    
}

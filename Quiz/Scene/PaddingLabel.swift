//
//  PaddingLabel.swift
//  Quiz
//
//  Created by dev dfcc on 7/23/25.
//
import UIKit

final class PaddedLabel: UILabel {
    private var textInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

    init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.textInset =  UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInset))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInset.left + textInset.right,
                      height: size.height + textInset.top + textInset.bottom)
    }
}

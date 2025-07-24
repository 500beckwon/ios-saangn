//
//  AnswerTextfield.swift
//  Quiz
//
//  Created by dev dfcc on 7/15/25.
//

import UIKit

protocol AnswerTextfieldDelegate: AnyObject {
    func textFieldDidChange(text: String)
}

final class AnswerTextfield: UITextField, UITextFieldDelegate {
    
    weak var customDelegate: AnswerTextfieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
    }
}

extension AnswerTextfield {
    func setup() {
        delegate = self
        textAlignment = .left
        font = .boldSystemFont(ofSize: 40)
        keyboardType = .default
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        customDelegate?.textFieldDidChange(text: textField.text ?? "")
        let graphemes = Array(text)
        if graphemes.count > 2 {
            let trimmed = graphemes.prefix(2).map { String($0) }.joined()
            textField.text = trimmed
            customDelegate?.textFieldDidChange(text: textField.text ?? "")
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // 빈 문자열은 허용 (삭제 등)
        guard !string.isEmpty else { return true }
        
        // 한글 유니코드 범위 확인
        for scalar in string.unicodeScalars {
            let value = scalar.value
            let isHangul =
            (value >= 0xAC00 && value <= 0xD7A3) ||  // 가~힣 (완성형)
            (value >= 0x1100 && value <= 0x11FF) ||  // 초성
            (value >= 0x3130 && value <= 0x318F)     // 호환 자모
            
            if !isHangul {
                return false // 한글 이외 문자는 거부
            }
        }
        
        // ✅ 입력은 일단 4자까지 허용
        // (겹받침 등 조합 중간에 걸리면 끊기기 때문에 약간 여유)
        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        return updatedText.count <= 4
    }
    
    // 조합 끝났을 때도 잘라주기 위해 텍스트 변경 감지
    @objc func textChanged(_ textField: UITextField) {
        if let markedTextRange = textField.markedTextRange, textField.position(from: markedTextRange.start, offset: 0) != nil {
            // 조합 중이면 무시
            return
        }
        if let text = textField.text, text.count > 1 {
            textField.text = String(text.prefix(1))
            customDelegate?.textFieldDidChange(text: textField.text ?? "")
        }
    }
}

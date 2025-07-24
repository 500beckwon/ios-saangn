//
//  QuizBoxView.swift
//  Quiz
//
//  Created by dev dfcc on 7/15/25.
//

import UIKit

protocol QuizBoxViewDelegate: AnyObject {
    func didSeletcedQuizBox(_ typo: AnswerType)
}

final class QuizBoxView: UIView {
    weak var delegate: QuizBoxViewDelegate?
    
    private var firstLabel = UILabel()
    private var secondLabel = UILabel()
    private var textfield = AnswerTextfield()
    private var resultButton1 = ResultButton()
    private var resultButton2 = ResultButton()
    private var hintBackGroundLabel = UILabel()
    private var hintLabel = UILabel()
    
    private var characterLabels: [UILabel] = []
    private let maxLength = 2  // 원하는 글자 수
    
    private var stackView = UIStackView()
    
    var answer: String {
        return (textfield.text ?? "")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showHint(text: String) {
        hintLabel.isHidden = false
        hintBackGroundLabel.isHidden = false
        hintLabel.text = text
    }
    
    func dashLine() {
        addDashedBorder(to: resultButton1)
        addDashedBorder(to: resultButton2)
    }
    
    func lockTextField() {
        textfield.isUserInteractionEnabled = false
    }
    
    func activeBox() {
        isUserInteractionEnabled = true
        textfield.becomeFirstResponder()
    }
    
    func showResult(result: [AnswerType]) {
        resultButton1.resultType = result[0]
        resultButton2.resultType = result[1]
    }
}

private extension QuizBoxView {
    func layout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        addSubview(stackView)
        addSubview(hintBackGroundLabel)
        addSubview(hintLabel)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(resultButton1)
        stackView.addArrangedSubview(resultButton2)
        addSubview(textfield)
        
    }
    
    func basicSetUI() {
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        hintBackGroundLabel.translatesAutoresizingMaskIntoConstraints = false
        hintBackGroundLabel.isHidden = true
        hintBackGroundLabel.backgroundColor = .clear
        hintBackGroundLabel.textColor = .black
        hintBackGroundLabel.text = "🎃"
        hintBackGroundLabel.font = .boldSystemFont(ofSize: 30)
        hintBackGroundLabel.textAlignment = .center
        
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.isHidden = true
        hintLabel.backgroundColor = .clear
        hintLabel.textColor = .black
        hintLabel.textAlignment = .center
        hintLabel.font = .boldSystemFont(ofSize: 25)
        
        firstLabel.layer.borderWidth = 2
        firstLabel.layer.borderColor = UIColor.black.cgColor
        firstLabel.layer.cornerRadius = 5
        
        secondLabel.layer.borderWidth = 2
        secondLabel.layer.borderColor = UIColor.black.cgColor
        secondLabel.layer.cornerRadius = 5
        
        textfield.tintColor = .clear
        textfield.backgroundColor = .clear
        textfield.textColor = .clear
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.customDelegate = self

        firstLabel.textAlignment = .center
        firstLabel.textColor = .black
        firstLabel.font = .boldSystemFont(ofSize: 25)
        
        secondLabel.textAlignment = .center
        secondLabel.textColor = .black
        secondLabel.font = .boldSystemFont(ofSize: 25)
        
        resultButton1.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        resultButton2.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func anchorUI() {
        NSLayoutConstraint.activate(
            [
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                hintBackGroundLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 1),
                hintBackGroundLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
                hintBackGroundLabel.widthAnchor.constraint(equalToConstant: 40),
                hintBackGroundLabel.heightAnchor.constraint(equalToConstant: 40)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                hintLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 1),
                hintLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
                hintLabel.widthAnchor.constraint(equalToConstant: 35),
                hintLabel.heightAnchor.constraint(equalToConstant: 35)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                textfield.leadingAnchor.constraint(equalTo: leadingAnchor),
                textfield.topAnchor.constraint(equalTo: topAnchor),
                textfield.bottomAnchor.constraint(equalTo: bottomAnchor),
                textfield.widthAnchor.constraint(equalToConstant: 150)
            ]
        )
    }
    
    @objc func resultButtonTapped(_ sender: ResultButton) {
        print(sender.resultType.icon)
        delegate?.didSeletcedQuizBox(sender.resultType)
    }
}

extension QuizBoxView: AnswerTextfieldDelegate {
    func textFieldDidChange(text: String) {
        let characterLabels = [firstLabel, secondLabel]
        let graphemes = Array(text)

        for i in 0..<characterLabels.count {
            if i < graphemes.count {
                characterLabels[i].text = String(graphemes[i])
            } else {
                characterLabels[i].text = "" // 빈 칸 유지
            }
        }
    }
}

//
//  ViewController.swift
//  Quiz
//
//  Created by dev dfcc on 7/15/25.
//

import UIKit

final class ViewController: UIViewController, UITextFieldDelegate {
    
    private var iconImageView = UIImageView()
    private var titleLabel = UILabel()
    private var helpButton = UIButton()
    private var hintButton = UIButton()
    private var stackView = UIStackView()
    private var boxViews = [QuizBoxView]()
    
    private var answerButton = UIButton()
    private var guideView = GuideView()
    
    private var tryCount = 0
    private var answer = "김밥"
    private var guideViewBottomConstrait: NSLayoutConstraint?
    private var guideViewHeightConstrait: NSLayoutConstraint?
    private var isShowGuide = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        boxViews.forEach {
            $0.dashLine()
        }
    }
    
}

private extension ViewController {
    
    @objc func hintButtonTapped(_ sender: UIButton) {
        sender.alpha = 0.5
        sender.isEnabled = false
        
        let count = tryCount > 0 ? tryCount - 1 : 0
        let hints = HangulAnalyzer.decomposeHangul(answer)
        let randomCount = Int.random(in: 0..<hints.count)
        let hint = " \(hints[randomCount])"
        let boxView = boxViews[count]
        boxView.showHint(text: hint)
    }
    
    @objc func answerButtonTapped(_ sender: UIButton) {
        
        let boxView = boxViews[tryCount]
        let tag = boxView.tag
        let inputText = boxView.answer
        guard inputText.count == 2 else { return }
        
        let result = HangulAnalyzer.evaluateWord(input: inputText, answer: answer)
        
        boxView.showResult(result: result)
        boxView.lockTextField()
        boxView.endEditing(true)

        if tag <= 5 {
            tryCount += 1
            boxViews[tryCount].activeBox()
        }
        
        if hintButton.alpha == 0 {
            hintButton.alpha = 1
        }
        
        if tag == 6 {
            answerButton.isHidden = true
        }
        
        if result[0] == .carrot && result[1] == .carrot {
            print("축하!")
            view.endEditing(true)
            boxViews.forEach { $0.lockTextField() }
        } else {
            if tag == 6 {
                print("오늘은 꽝")
            }
        }
    }
    
    @objc func helpButtonTapped(_ sender: UIButton) {
        let guide = Guide.allGuide
        guideView.guides = guide
        
        if isShowGuide {
            guideViewHeightConstrait?.constant = 0
            guideViewBottomConstrait?.constant = -300
        } else {
            guideViewHeightConstrait?.constant = view.frame.height - 200
            guideViewBottomConstrait?.constant = 0
        }
        isShowGuide = !isShowGuide
    }
}

extension ViewController: QuizBoxViewDelegate {
    func didSeletcedQuizBox(_ typo: AnswerType) {
        let guide = [Guide(messageOwner: .answer, message: typo.description), Guide(messageOwner: .end, message: " 닫기 ")]
        
        guideView.guides = guide
        
        guideViewHeightConstrait?.constant = 250
        guideViewBottomConstrait?.constant = 0
    }
}

extension ViewController: GuideViewDelegate {
    func endGuide() {
        guideViewHeightConstrait?.constant = 0
        guideViewBottomConstrait?.constant = 300
    }
}

private extension ViewController {
    
    func layout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        view.addSubview(iconImageView)
        view.addSubview(titleLabel)
        view.addSubview(helpButton)
        view.addSubview(hintButton)
        view.addSubview(stackView)
        view.addSubview(answerButton)
        view.addSubview(guideView)
    }
    
    func basicSetUI() {
        viewBasicSet()
        stackViewBasicSet()
        boxViewsBasicSet()
        answerButtonBasicSet()
        iconImageViewBasicSet()
        helpButtonBasicSet()
        hintButtonBasicSet()
        titleLabelBasicSet()
        guideViewBasicSet()
    }
    
    func anchorUI() {
        stackViewAnchor()
        answerButtonAnchor()
        iconImageViewAnchor()
        titleLabelAnchor()
        helpButtonAnchor()
        hintButtonAnchor()
        guideViewAnchor()
    }
    
    func viewBasicSet() {
        view.backgroundColor = .white
    }
    
    func iconImageViewBasicSet() {
        iconImageView.backgroundColor = .orange
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 15
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func titleLabelBasicSet() {
        titleLabel.text = "쌍근"
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func helpButtonBasicSet() {
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "questionmark.circle", withConfiguration: config)
        helpButton.setImage(image, for: .normal)
        helpButton.backgroundColor = .clear
        helpButton.tintColor = .black
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.addTarget(self, action: #selector(helpButtonTapped), for: .touchUpInside)
    }
    
    func hintButtonBasicSet() {
        hintButton.setTitle("🎃", for: .normal)
        hintButton.backgroundColor = .clear
        hintButton.setTitleColor(.black, for: .normal)
        hintButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
        hintButton.translatesAutoresizingMaskIntoConstraints = false
        hintButton.alpha = 0
        hintButton.addTarget(self, action: #selector(hintButtonTapped), for: .touchUpInside)
    }
    
    func stackViewBasicSet() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func answerButtonBasicSet() {
        answerButton.setTitle("제출", for: .normal)
        answerButton.backgroundColor = .white
        answerButton.layer.borderWidth = 3
        answerButton.layer.borderColor = UIColor.orange.cgColor
        answerButton.layer.cornerRadius = 5
        answerButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
        answerButton.setTitleColor(.orange, for: .normal)
        answerButton.translatesAutoresizingMaskIntoConstraints = false
        answerButton.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
    }
    
    func boxViewsBasicSet() {
        for i in 0...6 {
            let boxView = QuizBoxView()
            boxView.delegate = self
            boxView.tag = i
            boxView.isUserInteractionEnabled = i == 0
            
            boxView.frame.size.height = 60
            boxViews.append(boxView)
            stackView.addArrangedSubview(boxView)
        }
    }
    
    func guideViewBasicSet() {
        guideView.translatesAutoresizingMaskIntoConstraints = false
        guideView.delegate = self
    }
    
    func stackViewAnchor() {
        NSLayoutConstraint
            .activate(
                [
                    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                    stackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
                    stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 80),
                    stackView.heightAnchor.constraint(equalToConstant: 500)
                ]
            )
    }
    
    func answerButtonAnchor() {
        NSLayoutConstraint
            .activate(
                [
                    answerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
                    answerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    answerButton.widthAnchor.constraint(equalToConstant: 100),
                    answerButton.heightAnchor.constraint(equalToConstant: 40),
                    
                ]
            )
    }
    
    func iconImageViewAnchor() {
        NSLayoutConstraint
            .activate(
                [
                    iconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    iconImageView.widthAnchor.constraint(equalToConstant: 40),
                    iconImageView.heightAnchor.constraint(equalToConstant: 40),
                    iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
                ]
            )
    }
    
    func titleLabelAnchor() {
        NSLayoutConstraint
            .activate(
                [
                    titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
                    titleLabel.heightAnchor.constraint(equalToConstant: 30),
                    titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
                ]
            )
    }
    
    func helpButtonAnchor() {
        NSLayoutConstraint
            .activate(
                [
                    helpButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4),
                    helpButton.widthAnchor.constraint(equalToConstant: 40),
                    helpButton.heightAnchor.constraint(equalToConstant: 40),
                    helpButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
                ]
            )
    }
    
    func hintButtonAnchor() {
        NSLayoutConstraint
            .activate(
                [
                    hintButton.leadingAnchor.constraint(equalTo: helpButton.trailingAnchor, constant: 4),
                    hintButton.widthAnchor.constraint(equalToConstant: 40),
                    hintButton.heightAnchor.constraint(equalToConstant: 40),
                    hintButton.centerYAnchor.constraint(equalTo: helpButton.centerYAnchor)
                ]
            )
    }
    
    func guideViewAnchor() {
        guideViewBottomConstrait = guideView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 300)
        guideViewHeightConstrait = guideView.heightAnchor.constraint(equalToConstant: 0)
        guideViewBottomConstrait?.isActive = true
        guideViewHeightConstrait?.isActive = true
        
        NSLayoutConstraint
            .activate([
                guideView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                guideView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
}


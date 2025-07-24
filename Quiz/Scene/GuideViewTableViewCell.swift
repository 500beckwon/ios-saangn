//
//  GuideViewTableViewCell.swift
//  Quiz
//
//  Created by dev dfcc on 7/23/25.
//

import UIKit

class GuideViewTableViewCell: UITableViewCell {
    
    var answerLabel = PaddedLabel(left: 5, right: 5)
    var selectLabel = PaddedLabel(left: 5, right: 5)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectLabel.isHidden = true
        answerLabel.isHidden = true
        selectLabel.text = ""
        answerLabel.text = ""
        selectLabel.textColor = .black
    }
    
    func configureCell(guide: Guide) {
        switch guide.messageOwner {
        case .answer:
            answerLabel.isHidden = false
            answerLabel.text = guide.message
        case .question:
            selectLabel.isHidden = false
            selectLabel.text = guide.message
        case .end:
            selectLabel.isHidden = false
            selectLabel.text = guide.message
            selectLabel.textColor = .blue
        }
    }
    
    func setup() {
        contentView.addSubview(answerLabel)
        contentView.addSubview(selectLabel)
        
        contentView.backgroundColor = .systemBlue
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.textAlignment = .left
        answerLabel.textColor = .black
        answerLabel.backgroundColor = .white
        answerLabel.font = .boldSystemFont(ofSize: 25)
        answerLabel.isHidden = true
        answerLabel.numberOfLines = 0
        answerLabel.layer.cornerRadius = 5
        answerLabel.clipsToBounds = true
        
        selectLabel.translatesAutoresizingMaskIntoConstraints = false
        selectLabel.textAlignment = .right
        selectLabel.textColor = .black
        selectLabel.backgroundColor = .yellow
        selectLabel.font = .boldSystemFont(ofSize: 25)
        selectLabel.isHidden = true
        selectLabel.numberOfLines = 0
        selectLabel.layer.cornerRadius = 5
        selectLabel.clipsToBounds = true

        NSLayoutConstraint.activate(
            [
                answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                answerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
                answerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
                
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                selectLabel.topAnchor.constraint(equalTo: contentView.topAnchor
                                                 , constant: 10),
                selectLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                selectLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
                
            ]
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


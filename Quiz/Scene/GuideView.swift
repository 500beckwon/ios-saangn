//
//  GuideView.swift
//  Quiz
//
//  Created by dev dfcc on 7/22/25.
//

import UIKit

protocol GuideViewDelegate: AnyObject {
    func endGuide()
}

final class GuideView: UIView {
    weak var delegate: GuideViewDelegate?
    private var tableView = UITableView()
    
    
    var guides = [Guide]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GuideView {
    func setup() {
        addSubview(tableView)
        backgroundColor = .systemBlue
        layer.borderWidth = 3
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GuideViewTableViewCell.self, forCellReuseIdentifier: "GuideViewTableViewCell")
        tableView.backgroundColor = .clear
        
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func heightForMultilineText(_ text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

        let boundingBox = text.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )

        return ceil(boundingBox.height)
    }
}

extension GuideView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = guides[indexPath.row].message
        let height = heightForMultilineText(text, width: 300, font: .boldSystemFont(ofSize: 25))
        
        return height + 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = guides[indexPath.row].messageOwner
        if type == .end {
            delegate?.endGuide()
        }
    }
}

extension GuideView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GuideViewTableViewCell") as? GuideViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(guide: guides[indexPath.row])
        
        return cell
    }
}

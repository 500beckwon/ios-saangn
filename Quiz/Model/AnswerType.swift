//
//  AnswerType.swift
//  Quiz
//
//  Created by dev dfcc on 7/24/25.
//

import UIKit

enum AnswerType: CaseIterable {
    case banana
    case apple
    case mushroom
    case carrot
    case eggPlant
    case garlic
    case none
    
    var icon: String {
        switch self {
        case .banana:
            return "🍌"
        case .apple:
            return "🍎"
        case .mushroom:
            return "🍄"
        case .carrot:
            return "🥕"
        case .eggPlant:
            return "🍆"
        case .garlic:
            return "🧄"
        case .none:
            return ""
        }
    }
    
    var color: UIColor {
        switch self {
        case .banana:
            return .yellow
        case .apple:
            return .red
        case .mushroom:
            return .brown
        case .carrot:
            return .orange
        case .eggPlant:
            return .purple
        case .garlic:
            return .gray
        case .none:
            return .white
        }
    }
    
    var description: String {
        switch self {
        case .banana:
            return "🍌 반대로요~\n입력한 자음과 모음 중 1개 이상 있긴 있는데 반대쪽 글자에서 일치해요"
        case .apple:
            return "🍎 사과를 받아주세요~\n정답 두 글자 모두에서 일치하는 자음과 모음이 없어요"
        case .mushroom:
            return "🍄 비슷해요~\n자음과 모음 중 2개 이상이 일치하고 첫 자음도 일치해요"
        case .carrot:
            return "🥕 당연하죠~\n해당 글자와 일치해요"
        case .eggPlant:
            return "🍆 가지고 있어요~\n입력한 자음과 모음 중 하나만 있어요"
        case .garlic:
            return "🧄 많을 거예요~\n자음과 모음 중 2개 이상이 있지만 첫 자음은 일치하지 않아요"
        case .none:
            return ""
        }
    }
    
    static var example: String {
        return """
        예를 들면
        '관계'라는 정답은
        올해 🍆🍎
        인사 🍆🍌
        악보 🧄🍌
        과일 🍄🍎
        관점 🥕🍎
        관계 🥕🥕
        """
    }
    
    static var allSimpleDescription: String {
        return """
        힌트들의 뜻이 뭐예요?
        간단하게
        🥕 당연하죠~
        🍄 비슷해요~
        🧄 많을 거예요~
        🍆 가지고 있어요~
        🍌 반대로요~
        🍎 사과를 받아주세요~
        """
    }
    
    static var allDescription: String {
        return AnswerType.allCases.enumerated().map { index, type in
            if index == 6 {
                return ""
            }
            return "\(type.icon) \(type.description)\n\n"
        }.joined()
    }
}

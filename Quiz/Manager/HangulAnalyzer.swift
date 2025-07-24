//
//  HangulAnalyzer.swift
//  Quiz
//
//  Created by dev dfcc on 7/15/25.
//

// 🧠 한글 분해 및 평가 담당 클래스
class HangulAnalyzer {
    
    // 초성
    static let choseongs = Array("ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ")
    // 중성
    static let jungseongs = Array("ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ")
    // 종성
    static let jongseongList: [String] = ["", "ㄱ","ㄲ","ㄳ","ㄴ","ㄵ","ㄶ",
                                          "ㄷ","ㄹ","ㄺ","ㄻ","ㄼ","ㄽ","ㄾ","ㄿ","ㅀ",
                                          "ㅁ","ㅂ","ㅄ","ㅅ","ㅆ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

    struct DecomposedChar {
        let choseong: Character?
        let jungseong: Character?
        let jongseong: Character?
        
        var set: Set<Character> {
            var components: Set<Character> = []
            if let ch = choseong {
                components.insert(ch)
            }
            if let ju = jungseong {
                components.formUnion(HangulAnalyzer.expandJungseong(ju))
            }
            if let jo = jongseong {
                components.insert(jo)
            }
            return components
        }

    }
    
    static func expandJungseong(_ j: Character) -> Set<Character> {
        switch j {
        case "ㅘ": return ["ㅗ", "ㅏ"]
        case "ㅙ": return ["ㅗ", "ㅐ"]
        case "ㅚ": return ["ㅗ", "ㅣ"]
        case "ㅝ": return ["ㅜ", "ㅓ"]
        case "ㅞ": return ["ㅜ", "ㅔ"]
        case "ㅟ": return ["ㅜ", "ㅣ"]
        case "ㅢ": return ["ㅡ", "ㅣ"]
        default:
            return [j]
        }
    }
    
    // 한글 분해 함수
    static func decompose(_ char: Character) -> DecomposedChar {
        let base: UInt32 = 0xAC00
        guard let scalar = char.unicodeScalars.first else {
            return DecomposedChar(choseong: nil, jungseong: nil, jongseong: nil)
        }
        let code = scalar.value - base
        guard code >= 0 && code < 11172 else {
            return DecomposedChar(choseong: nil, jungseong: nil, jongseong: nil)
        }
        
        let choseongIndex = Int(code / 588)
        let jungseongIndex = Int((code % 588) / 28)
        let jongseongIndex = Int(code % 28)
        
        let choseong = choseongs[choseongIndex]
        let jungseong = jungseongs[jungseongIndex]
        let jongseong = jongseongIndex > 0 ? Character(jongseongList[jongseongIndex]) : nil
        
        return DecomposedChar(choseong: choseong, jungseong: jungseong, jongseong: jongseong)
    }
    
    /// 힌트 용 한글 분해 함수
    static func decomposeHangul(_ text: String) -> [String] {
        let baseCode: UInt32 = 0xAC00
        let chosung = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ",
                       "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ",
                       "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
        let jungsung = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ",
                        "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ",
                        "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ",
                        "ㅡ", "ㅢ", "ㅣ"]
        let jongsung = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ",
                        "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ",
                        "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ",
                        "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

        var result: [String] = []

        for scalar in text.unicodeScalars {
            let code = scalar.value
            if code >= baseCode && code <= 0xD7A3 {
                let index = code - baseCode
                let cho = Int(index / (21 * 28))
                let jung = Int((index % (21 * 28)) / 28)
                let jong = Int(index % 28)

                result.append(chosung[cho])
                result.append(jungsung[jung])
                if !jongsung[jong].isEmpty {
                    result.append(jongsung[jong])
                }
            } else {
                // 한글이 아닌 경우 그대로 추가
                result.append(String(scalar))
            }
        }

        return result
    }
    
    // 메인 평가 함수
    static func evaluateWord(input: String, answer: String) -> [AnswerType] {
        let inputChars = Array(input)
        let answerChars = Array(answer)
        
        guard inputChars.count == answerChars.count else {
            return Array(repeating: .none, count: inputChars.count)
        }
        
        var results: [AnswerType] = []
        
        for i in 0..<inputChars.count {
            let inputChar = inputChars[i]
            let answerChar = answerChars[i]
            
            if inputChar == answerChar {
                results.append(.carrot) // 🥕 완전 일치
                continue
            }
            
            let inputParts = decompose(inputChar)
            let answerParts = decompose(answerChar)
            
            let inputSet = inputParts.set
            let answerSet = answerParts.set
            let matchCount = inputSet.intersection(answerSet).count
            
            // 🍄 mushroom: 2개 이상 + 첫 자음 일치
            if matchCount >= 2 && inputParts.choseong == answerParts.choseong {
                results.append(.mushroom)
            }
            // 🧄 garlic: 2개 이상, 첫 자음 불일치
            else if matchCount >= 2 {
                results.append(.garlic)
            }
            // 🍆 eggPlant: 1개 일치
            else if matchCount == 1 {
                results.append(.eggPlant)
            }
            // 🍌 banana: 현재 글자와는 안 맞지만 반대쪽 글자와 일부 자모 일치
            else {
                let oppositeIndex = (i == 0) ? 1 : 0
                let otherAnswerChar = answerChars[oppositeIndex]
                let otherAnswerParts = decompose(otherAnswerChar)
                let otherAnswerSet = otherAnswerParts.set
                let crossMatch = inputSet.intersection(otherAnswerSet).count
                if crossMatch > 0 {
                    results.append(.banana)
                } else {
                    results.append(.apple)
                }
            }
        }
        
        return results
    }
}

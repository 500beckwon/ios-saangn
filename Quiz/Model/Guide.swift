//
//  Guide.swift
//  Quiz
//
//  Created by dev dfcc on 7/23/25.
//

struct Guide {
    let messageOwner: messageOwner
    let message: String
    
    enum messageOwner {
        case end
        case answer
        case question
    }
    
    
    static var allGuide: [Guide] {
        return [
            Guide(messageOwner: .question, message: "규칙이 뭐에요?"),
            Guide(messageOwner: .answer, message: "1. 암호는\n2글자입니다"),
            Guide(messageOwner: .answer, message: "2. 7번의 시도안에 암호를 맞춰보세요"),
            Guide(messageOwner: .answer, message: "3. 추측한 자음과 모음에\n힌트가 주어집니다"),
            Guide(messageOwner: .question, message: "자음과 모음이 뭐예요?"),
            Guide(messageOwner: .answer, message: "자음~ㄱㄴㄷㄹㅁㅂㅅ\nㅇㅈㅊㅋㅌㅍㅎ\nㄲㄸㅃㅆㅉ"),
            Guide(messageOwner: .answer, message: "모음~\nㅏㅐㅑㅒㅓㅔㅕ\nㅖㅗㅛㅜㅠㅡ"),
            Guide(messageOwner: .question, message: "힌트들의 뜻이 뭐예요?"),
            Guide(messageOwner: .answer, message: "간단하게\n🥕 당연하죠~\n🍄 비슷해요~\n🧄 많을 거예요~\n🍆 가지고 있어요~\n🍌 반대로요~\n🍎 사과를 받아주세요~"),
            Guide(messageOwner: .question, message: "무슨 말이에요?"),
            Guide(messageOwner: .answer, message: AnswerType.allDescription),
            Guide(messageOwner: .question, message: "보기가 있어요?"),
            Guide(messageOwner: .answer, message: AnswerType.example),
            Guide(messageOwner: .end, message: "넵 알겠습니다!"),
        ]
    }
}

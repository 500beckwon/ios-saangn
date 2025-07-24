//
//  QuizTests.swift
//  QuizTests
//
//  Created by dev dfcc on 7/24/25.
//

@testable import Quiz
import XCTest

final class QuizTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_한글분해_확인여부1() {
        XCTAssertEqual(["ㄱ","ㅣ","ㅁ","ㅂ","ㅏ","ㅂ"],HangulAnalyzer.decomposeHangul("김밥"))
    }
    
    func test_한글분해_확인여부2() {
        XCTAssertEqual(["ㄱ","ㅘ","ㄴ","ㄱ","ㅖ"],HangulAnalyzer.decomposeHangul("관계"))
    }
    
    func test_한글분해_불일치1() {
        XCTAssertNotEqual(["ㄱ","ㅓ","ㄴ","ㄱ","ㅖ"],HangulAnalyzer.decomposeHangul("관계"))
    }
    
    func test_한글분해_불일치2() {
        XCTAssertNotEqual(["ㄱ","ㅣ","ㅁ","ㅂ","ㅏ","ㅂ"],HangulAnalyzer.decomposeHangul("기밥"))
    }
}

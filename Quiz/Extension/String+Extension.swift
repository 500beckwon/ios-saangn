//
//  String+Extension.swift
//  Quiz
//
//  Created by dev dfcc on 7/21/25.
//

import Foundation

extension String {
    func countGraphemes() -> Int {
        return self.unicodeScalars.reduce(into: (count: 0, isCombining: false)) { result, scalar in
            if !CharacterSet.nonBaseCharacters.contains(scalar) {
                result.count += 1
                result.isCombining = false
            } else if !result.isCombining {
                result.count += 1
                result.isCombining = true
            }
        }.count
    }
}

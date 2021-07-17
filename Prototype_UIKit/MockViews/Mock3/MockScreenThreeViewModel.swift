//
//  MockScreenThreeViewModel.swift
//  Prototype_SwiftUI
//
//  Created by Ralph Schnalzenberger on 27.06.21.
//

import Foundation

final class MockScreenThreeViewModel: ObservableObject {
    private var selectedAnswers: [Question: Int] = [:]
    
    let questions = Question.allCases
    
    func selectAnswer(at index: Int, for question: Question) {
        if selectedAnswers.contains(where: { $0.key == question }) {
            selectedAnswers.removeValue(forKey: question)
        } else {
            selectedAnswers[question] = index
        }
    }
}

enum Question: CaseIterable, Hashable {
    case one, two

    var title: String {
        switch self {
        case .one:
            return "Can you answer the first question?"
        case .two:
            return "How about the second question?"
        }
    }
    
    var description: String {
        switch self {
        case .one:
            return "This is a description"
        case .two:
            return "This is also an description"
        }
    }
    
    var potentialAnswers: [String] {
        switch self {
        case .one:
            return ["Test1", "Test2", "Test3", "Test4",]
        case .two:
            return ["Test1", "Test2", "Test3", "Test4",]
        }
    }
}

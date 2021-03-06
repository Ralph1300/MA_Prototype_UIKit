//
//  WorkoutFactory.swift
//  Prototype_SwiftUI
//
//  Created by Ralph Schnalzenberger on 06.07.21.
//

import Foundation

struct Exercise: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let value: String
    
    var text: String {
        return "\(value)s \(name)"
    }
}

struct Round: Identifiable, Hashable {
    let id = UUID()
    let exercises: [Exercise]
}

struct Workout {
    let name: String
    let description: String
    let rounds: [Round]
    let warmup: Round?
}

enum WorkoutFactory {
    
    static func makeWorkout(roundCount rounds: Int, includeWarmup: Bool) -> Workout {
        return Workout(name: "Alpha",
                       description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.",
                       rounds: makeRounds(rounds, exerciseCount: 5),
                       warmup: includeWarmup ? makeWarmup() : nil)
    }
    
    private static func makeRounds(_ count: Int, exerciseCount: Int) -> [Round] {
        return (0..<count).map { _ in
            return Round(exercises: (0..<exerciseCount).map { _ in
                            Exercise(name: "Push-ups", value: "30")
            })
        }
    }
    
    private static func makeWarmup() -> Round? {
        return makeRounds(1, exerciseCount: 7).first
    }
}

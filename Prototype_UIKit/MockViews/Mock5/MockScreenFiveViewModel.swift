//
//  MockScreenFiveViewModel.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 20.07.21.
//

import UIKit

enum WorkoutDetailSection: Hashable {
    case warmup
    case round(index: Int)
    
    var text: String {
        switch self {
        case .warmup:
            return "Warmup"
        case .round(let idx):
            return "Round \(idx + 1)"
        }
    }
}

final class MockScreenFiveViewModel {
    let workout: Workout
    
    var warmupIsShown = true
    
    var sections: [WorkoutDetailSection] {
        var sections: [WorkoutDetailSection] = []
        if workout.warmup != nil {
            sections.append(.warmup)
        }
        for idx in 0..<workout.rounds.count {
            sections.append(.round(index: idx))
        }
        return sections
    }
    
    var personalBestIcon: UIImage {
        return UIImage(systemName: "timer")!
    }
    
    var descriptionIcon: UIImage {
        return UIImage(systemName: "heart.text.square.fill")!
    }
    
    var personalBest: String {
        return "02:30"
    }
    
    var exerciseImage: UIImage {
        return UIImage(systemName: "rectangle.stack.person.crop")!
    }
    
    init(workout: Workout = WorkoutFactory.makeWorkout(roundCount: 5, includeWarmup: true)) {
        self.workout = workout
    }
    
    func items(for section: WorkoutDetailSection) -> [Exercise] {
        switch section {
        case .warmup:
            return warmupIsShown ? workout.warmup?.exercises ?? [] : []
        case .round(let idx):
            return workout.rounds[idx].exercises
        }
    }
}

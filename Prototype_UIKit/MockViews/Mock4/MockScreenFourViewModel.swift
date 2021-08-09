//
//  MockScreenFourViewModel.swift
//  Prototype_SwiftUI
//
//  Created by Ralph Schnalzenberger on 29.06.21.
//

import UIKit

struct RowItem: Equatable {
    enum ItemType: Equatable {
        case image(UIImage)
        case title(String)
    }
    let itemType: ItemType
    let title: String
    let description: String
}

struct ExampleWorkout: Identifiable, Equatable {
    let id = UUID()
    let day: String
    let title: String
    let exercises: String
}

struct ExampleUserReview: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let review: String
    let image: UIImage
}

final class MockScreenFourViewModel {
    
    let headerImage = UIImage(named: "workout_header")!
    let title = "Some training plan"
    let description = "This is some training plan that I really can recommend"
    let duration = "4 weeks"
    
    let workouts: [ExampleWorkout] = [ExampleWorkout(day: "MON", title: "Workout 1", exercises: "Burpees, Burpees and more Burpees"),
                                      ExampleWorkout(day: "WED", title: "Workout 2", exercises: "Pushups, Burpees and more Squats"),
                                      ExampleWorkout(day: "FRI", title: "Workout 3", exercises: "Burpees, Squats and more Pushups")]
    
    let reviews: [ExampleUserReview] = [ExampleUserReview(name: "User1", age: 25, review: "This plan is a very nice addition to my other workout routine", image: UIImage(systemName: "person")!),
                                        ExampleUserReview(name: "User2", age: 19, review: "An awesome experience, I can only recommend it.", image: UIImage(systemName: "person.fill")!)]
    
    func makeWorkoutRowItems() -> [RowItem] {
        return workouts.map { RowItem(itemType: .title($0.day), title: $0.title, description: $0.exercises) }
    }
}


//
//  MockScreenTwoViewModel.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 20.06.21.
//

import UIKit

enum Country: Pickable, CaseIterable {
    case austria, germany, switzerland
    
    var descriptionText: String {
        switch self {
        case .austria:
            return "Austria"
        case .germany:
            return "Germany"
        case .switzerland:
            return "Switzerland"
        }
    }
}

enum Gender {
    case male, female, other
}

final class MockScreenTwoViewModel: ObservableObject {
    var firstName: String = ""
    var lastName: String = ""
    var userImage: UIImage?
    var gender: Gender = .male
    var email: String = ""
    var password: String = ""
    var birthday: Date = Date()
    var country = Country.austria

    private(set) lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    let countries = Country.allCases
    
    func register() {
        
    }
}

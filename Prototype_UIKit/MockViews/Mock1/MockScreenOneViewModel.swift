//
//  MockScreenOneViewModel.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 19.06.21.
//

import UIKit

final class MockScreenOneViewModel {
    enum LoginProvider: CaseIterable, Identifiable {
        case apple, facebook, google, registration
        
        var id: String { return "\(self)" }
    }
    
    private let providers: [LoginProvider] = LoginProvider.allCases
    private let fullWidthButtonCount = 2
    
    // MARK: - Internal
    
    var image: UIImage? {
        return UIImage(named: "logo")
    }
    
    var fullWidthProviders: [LoginProvider] {
        Array(providers.prefix(fullWidthButtonCount))
    }
    
    var wrappedWidthProviders: [LoginProvider] {
        Array(providers.dropFirst(fullWidthButtonCount))
    }
    
    func tapped(loginProvider: LoginProvider) {
        print("Logging in \(loginProvider)")
    }
    
    func loginViaEmail() {
        print("Logging in via Email")
    }
    
    func makeButtonTitle(for provider: LoginProvider) -> String {
        switch provider {
        case .apple:
            return "Sign in with Apple"
        case .registration:
            return "Sign up"
        case .facebook:
            return "Continue with Facebook"
        case .google:
            return "Google Sign In"
        }
    }
}

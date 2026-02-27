//
//  AuthManager.swift
//  Halo
//
//  Created by Gdwn16 on 25/02/2026.
//

import Foundation
import SwiftUI

@Observable
final class AuthManager {
    
    @ObservationIgnored // appstorage handles it's own observation
    @AppStorage("isLoggedIn") private(set) var _isLoggedIn: Bool = false
    
    var isLoggedIn: Bool {
        get {
            access(keyPath: \.isLoggedIn)
            return _isLoggedIn
        }
        set {
            withMutation(keyPath: \.isLoggedIn) {
                _isLoggedIn = newValue
            }
        }
    }

    func logIn() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
            self.isLoggedIn = true
        }
    }
    
    func logOut() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8)) {
            self.isLoggedIn = false
        }
    }
}



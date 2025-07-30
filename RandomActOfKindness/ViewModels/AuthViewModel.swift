//
//  AuthViewModel.swift
//  RandomActOfKindness
//
//  Created by Noah Flood on 7/27/25.
//

import Foundation
import FirebaseAuth

class AuthViewModel : ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    @Published var errorFlag: Bool = false
    @Published var errorCode: String = ""
    
    let auth = Auth.auth()
    
    init() {
        // keep state in sync with Firebase
        self.isLoggedIn = auth.currentUser != nil
        
        // listen for changes in auth state
        _ = auth.addStateDidChangeListener { [weak self] _, user in // ignores a warning about not setting the returned thing here
            self?.isLoggedIn = (user != nil) // don't understand this syntax, but it handles the
        }
    }
    
    // tricky syntax, closure indicates that the code runs later after the inital call once a result or error is returned.
    func login(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            // this guard makes sure result isn't nil, so we don't get a fatal error.
            guard result != nil, error == nil else {
                self.errorFlag = true
                // this could be formatted to be more user friendly.
                self.errorCode = error?.localizedDescription ?? "Unknown error"
                print("Login failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // success
            self.errorFlag = false
            self.isLoggedIn = true
            print("Login successful!")
        }
        
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                self.errorFlag = true
                // this could be formatted to be more user friendly.
                self.errorCode = error?.localizedDescription ?? "Unknown error"
                print("Login failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // success
            self.errorFlag = false
            self.isLoggedIn = true
            print("Account creation successful!")
        }
        
    }
    
    func logout() {
        do {
            try auth.signOut()
            self.isLoggedIn = false
            print("Logged out successfully")
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }
    
}

//
//  ContentView.swift
//  RandomActOfKindness
//
//  Created by Noah Flood on 7/25/25.
//

import SwiftUI

enum AuthScreen { // it's one or the other.
    // landing page is checked with the authvm.isLoggedIn() boolean!
    case login
    case signup
}

struct ContentView: View {
    
    @EnvironmentObject var appvm : MainViewModel
    @EnvironmentObject var authvm : AuthViewModel
    @State private var authScreen: AuthScreen = .login
    
    var body: some View {
        VStack {
            if authvm.isLoggedIn { // if we're logged in just go ahead and go to landingView
                LandingView()
            } else {
                switch authScreen {
                case .login:
                    LoginView(onSwitchToSignUp: {
                        authScreen = .signup
                    })
                case .signup:
                    SignUpView(onSwitchToLogin: {
                        authScreen = .login
                    })
                }
            }
        }
        .onAppear {
            appvm.loadActs()
            appvm.assignAct()
        }
        
    }

}

#Preview {
    ContentView()
        .environmentObject(MainViewModel())
        .environmentObject(AuthViewModel())
}

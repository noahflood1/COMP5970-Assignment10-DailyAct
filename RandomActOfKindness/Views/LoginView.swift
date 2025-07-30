//
//  LoginView.swift
//  RandomActOfKindness
//
//  Created by Noah Flood on 7/26/25.
//

import SwiftUI

struct LoginView: View {
    
    
    // when this closure gets "called" it's defintion in the
    // instantition of this view in the parent view (ContentView)
    // sets its content
    var onSwitchToSignUp: () -> Void  // don't really understand how this passes up, but it does
    // don't need this, it's handled in the AuthViewModel and ContentView with a flag
    //var onSwitchToLanding: () -> Void
    
    @EnvironmentObject var authvm : AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var showError = false // flag for authvm errors with login
    
    var body: some View {
        VStack {
            Spacer()
            
            // FORM -----------------------------------------------------------
            
            Text("Welcome to DailyAct")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                TextField("Username", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // LOGIN BUTTON -----------------------------------------------
                
                Button(action: {
                    if(password.isEmpty || email.isEmpty)
                    {
                        // don't allow the button to work
                    }
                    else
                    {
                        // try logging in
                        authvm.login(email: email, password: password)
                    }
                    })
                { // start of button content
                    Text("Login")
                        .frame(maxWidth: .infinity) // make it expand horizontally
                        .padding(.vertical, 8)     // internal padding for height
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                } //end of button content
                // showError is automatically reset after an alert
                .alert("Login failed", isPresented: $showError) {
                    Button("Ok", role: .cancel) { }
                } message: {
                    Text(authvm.errorCode)
                }
                .onChange(of: authvm.errorFlag) { _, newValue in
                    if newValue {
                        showError = true
                        authvm.errorFlag = false
                    }
                }
            } // end of Vstack
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 60)
            .padding(.bottom, 20)
            
            Button(action: {
                onSwitchToSignUp()
            }) {
                Text("New around here? Sign Up")
            }
            
            Spacer()
        }
    }

}


//#Preview {
//    LoginView(onSwitchToSignUp: { })
//        .environmentObject(AuthViewModel())
//}

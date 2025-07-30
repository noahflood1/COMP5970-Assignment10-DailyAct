//
//  LoginView.swift
//  RandomActOfKindness
//
//  Created by Noah Flood on 7/26/25.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var authvm : AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    
    @State private var showPasswordMismatchAlert = false // flag for the locally-identified error
    @State private var showError = false // flag for authvm errors with signup
    
    // this is how you declare a closure without it having anything in it yet
    var onSwitchToLogin: () -> Void
    
    var body: some View {
        
        VStack {
            Spacer()
            
            // FORM -----------------------------------------------------------
            
            Text("Sign Up for DailyAct")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                TextField("Username", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password) // dollar sign means its binding to state as the user types it, i think
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Confirm Password", text: $passwordConfirm)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // SIGNUP BUTTON -----------------------------------------------
                
                Button(
                    action: {
                        if (password.isEmpty || email.isEmpty || passwordConfirm.isEmpty)
                        {
                            // do nothing if any of the fields are empty
                        }
                        else
                        {
                            if password == passwordConfirm { // if the two pw fields match
                                
                                // try signing up by calling the authViewModel
                                showPasswordMismatchAlert = false // passwords must be matching now too
                                authvm.signUp(email: email, password: password)
                                
                            } else {showPasswordMismatchAlert = true} // otherwise, set the mismatch to true so that the appropriate alert is shown
                        }
                    }) // end of action, end of button params
                { // start of button content
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                // first alert on this button conditionally shown if password fields don't match
                // showPasswordMismatchAlert is automatically reset after an alert
                .alert("Passwords Do Not Match", isPresented: $showPasswordMismatchAlert) {
                    Button("OK", role: .cancel) { } }
                // second alert on this button conditionally shown if the login yielded an error
                .alert("Sign Up Failed", isPresented: $showError) {
                    Button("Ok", role: .cancel) {}
                } message: {
                    Text(authvm.errorCode) // shows the error description from the authViewModel
                }
                // an alternative here would be to check changes on the error message itself, but
                // i would have to make sure it isn't empty and stuff.
                .onChange(of: authvm.errorFlag) { _, newValue in
                    if newValue {
                        showError = true
                        authvm.errorFlag = false // reset so future errors can retrigger
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 60)
            .padding(.bottom, 20)
            
            // SWITCH PAGES BUTTON --------------------------------------------
            
            Button(action: {
                onSwitchToLogin() // somehow this works even tho the closure is empty in this view
            }) {
                Text("Already have an account? Login")
            }
            
            Spacer()
        }
    }

}


//#Preview {
//    SignUpView(onSwitchToLogin: { }) // necessary for the preview. look up why
//        .environmentObject(AuthViewModel())
//}

//
//  LandingView.swift
//  RandomActOfKindness
//
//  Created by Noah Flood on 7/26/25.
//

import SwiftUI

struct LandingView: View {
    
    @EnvironmentObject var appvm : MainViewModel
    @EnvironmentObject var authvm : AuthViewModel
    
    var body: some View {
        Spacer()
        Text("Your act of kindness for today:")
            .padding(.bottom, 10)
        Text(appvm.userProfile.assignedToday ?? "No act assigned yet")
            .padding(.bottom, 40)
            .fontWeight(.bold)
        Spacer()
        VStack {
            
            // #FIX ME: Show the date.
            
            Button(action: {
                
                // CALL LOGOUT
                authvm.logout()
                
            }) {
                Text("Logout")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 60)
        .padding(.bottom, 20)
    }
}

#Preview {
    LandingView()
        .environmentObject(MainViewModel())
        .environmentObject(AuthViewModel())
}

//
//  MainViewModel.swift
//  RandomActOfKindness
//
//  Created by Noah Flood on 7/25/25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class MainViewModel : ObservableObject {
    
    @Published var userProfile = UserProfileModel() // default empty profile
    @Published var acts: [ActModel] = [] // not used, meant to combine local acts and cloud stored ones.
    
    // LOGIN ------------------------------------------------------------------
    
    // moved to AuthViewModel
    
    // LOAD -------------------------------------------------------------------
    
    func loadActs() {
        // first load the local list
        self.acts = localActs
        
        // then fetch from Firestore and append/merge
        fetchGlobalActsFromFirestore() // (not doing anything as of now)
    }
    
    func assignAct() {
        // skip if already assigned
        if userProfile.assignedToday != nil {
            print("Today's act already assigned: \(userProfile.assignedToday!)")
            return
        }
        
        // pick a random act from the list locally
        // (doesn't use the "act" variable, which could have more in it.)
        if let randomAct = localActs.randomElement() {
            userProfile.assignedToday = randomAct.content
            print("Assigned today's act: \(randomAct)")
        }
    }
    
    // DATABASE FUNCTIONS -----------------------------------------------------
    
    let db = Firestore.firestore()
    
    func addExampleData() {
        // temp
    }
    
    func fetchGlobalActsFromFirestore() {
        // Fetch from Firestore collection "acts"
    }
    
    // FIRESTORE FUNCTIONS ----------------------------------------------------

    // would put this in its own ViewModel in a more complex project
    func fetchUserProfile(userId: String) {
        // Get Firestore document "users/\(userId)"
    }

    func markTodayCompleted() {
        // Update Firestore with today’s completion
    }

}

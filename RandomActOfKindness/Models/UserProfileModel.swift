//
//  UserProfileModel.swift
//  RandomActOfKindness
//
//  Created by Noah Flood on 7/26/25.
//

import Foundation
import FirebaseFirestore

struct UserProfileModel: Codable, Identifiable {
    @DocumentID var id: String?
    var assignedToday: String?  // The ID or content of today’s assigned act
    var history: [UserActHistory] // Completed acts
    
    init(assignedToday: String? = nil, history: [UserActHistory] = []) {
        self.assignedToday = assignedToday
        self.history = history
    }
}

// A separate struct to represent each day’s history
struct UserActHistory: Codable, Identifiable {
    var id: String { date.description } // unique per day
    var date: Date
    var actContent: String
    var completed: Bool
}

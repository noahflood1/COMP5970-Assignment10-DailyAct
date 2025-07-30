//
//  RandomActOfKindnessApp.swift
//  RandomActOfKindness
//
//  Created by Noah Flood on 7/25/25.
//

import SwiftUI
import FirebaseCore

// straight from Firebase console
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct RandomActOfKindnessApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // create an instance of the view model and pass it into the app's content view via environment object
    @StateObject var mainViewModel = MainViewModel()
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainViewModel)
                .environmentObject(authViewModel)
        }
    }
}

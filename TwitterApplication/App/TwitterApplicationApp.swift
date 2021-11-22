//
//  TwitterApplicationApp.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI
import Firebase

@main
struct TwitterApplicationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let userViewModel = UserViewModel()
            ContentView()
                .environmentObject(userViewModel)
                .environmentObject(AuthViewModel(users: userViewModel))
                .environmentObject(HomeViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


//
//  FinScopeswiftUIApp.swift
//  FinScopeswiftUI
//
//  Created by Tamara on 30/05/2025.
//

// FinScopeApp.swift
import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct FinScopeswiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authVM = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group{
                if authVM.isLoggedIn{
                    MainTabView()
                }else{
                    SplashView()
                }
            }
                .environmentObject(authVM)
        }
    }
}


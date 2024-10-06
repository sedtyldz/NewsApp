//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Sedat Yıldız on 11.09.2024.
//

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
struct NewsAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("islogin") var islogin:Bool = false
    var body: some Scene {
        WindowGroup {
            if islogin {
                MainPage()
            }
            else{
                ContentView()
            }
        }
    }
}

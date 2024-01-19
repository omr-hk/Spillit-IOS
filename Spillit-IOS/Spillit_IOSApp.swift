//
//  Spillit_IOSApp.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 27/12/23.
//

import SwiftUI
import FirebaseCore
import AppCheckCore
import FirebaseAppCheck

class YourAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    if #available(iOS 14.0, *) {
      return AppAttestProvider(app: app)
    } else {
      return DeviceCheckProvider(app: app)
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      let providerFactory = YourAppCheckProviderFactory()
      AppCheck.setAppCheckProviderFactory(providerFactory)

      FirebaseApp.configure()

    return true
  }
    
}

@main
struct Spillit_IOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


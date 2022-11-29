//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by NikoS on 21.09.2022.
//

import SwiftUI
import FirebaseCore
import UserNotifications
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseMessaging.Messaging.messaging().delegate = self
        FirebaseApp.configure()
        
        Messaging.messaging().token { token, error in
            if let token = token {
                print("Registration token is: \(token)")
            } else if let error = error {
                print("There is an error: \(error)")
            }
        }
        return true
        
    }
}

extension AppDelegate: MessagingDelegate {
    
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      if let token = fcmToken {
          do {
              try SecureStorage().put(object: token, for: SecureStorage.Keys.token)
          } catch {
              print(error)
          }
      }
      
    print("Firebase registration token: \(String(describing: fcmToken))")

    let dataDict: [String: String] = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: dataDict
    )
  }

}

@main
struct CryptoAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let viewModel = AuthViewModel()
            AuthView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, CoreDataStack.instance.mainContext)
        }
    }
    init() {
        if Reachability.isConnectedToNetwork() {
            UpdatingService.shared.deleteCoins()
            UpdatingService.shared.fetchCoins()
            CurrentDateChecker().setData()
            CurrentDateChecker().setHourlyArray()
        }
    }
    
}



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
import Reteno

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
//        Reteno initialization
        Reteno.start(apiKey: "630A66AF-C1D3-4F2A-ACC1-0D51C38D2B05")
        
//         Register for receiving push notifications
//         registerForRemoteNotifications will show the native iOS notification permission prompt
//         Provide UNAuthorizationOptions or use default
        Reteno.userNotificationService.registerForRemoteNotifications(with: [.sound, .alert, .badge], application: application)
        
//         Subscribing for remote notifications
        let notificationsCenter = UNUserNotificationCenter.current()
        notificationsCenter.requestAuthorization(options: [.sound, .alert, .badge]) { [weak self] granted, _ in
            if granted {
                notificationsCenter.delegate = self
            }

            notificationsCenter.getNotificationSettings { _ in
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        
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
              Reteno.userNotificationService.processRemoteNotificationsToken(token)
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

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.sound, .badge, .alert])
    }

    // SDK version 1.4.0 and later
        func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        Reteno.userNotificationService.processRemoteNotificationResponse(response)
        completionHandler()
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



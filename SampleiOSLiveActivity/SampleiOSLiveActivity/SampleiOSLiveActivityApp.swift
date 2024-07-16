//
//  SampleiOSLiveActivityApp.swift
//  SampleiOSLiveActivity
//
//  Created by Debanjan Chakraborty on 16/07/24.
//
import Foundation
import SwiftUI

@main
struct SampleiOSLiveActivityApp: App {

    init() {
        registerForNotification()
    }

    func registerForNotification() {
        UIApplication.shared.registerForRemoteNotifications()
        let center : UNUserNotificationCenter = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound , .alert , .badge ], completionHandler: { (granted, error) in
            if ((error != nil)) { UIApplication.shared.registerForRemoteNotifications() }
            else {

            }
        })
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

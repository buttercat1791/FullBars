//
//  AppDelegate.swift
//  FullBars
//
//  Created by Michael Jurkoic on 12/13/19.
//  Copyright © 2019 Michael Jurkoic. All rights reserved.
//

import BackgroundTasks
import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13, *) {
            BGTaskScheduler.shared.register(forTaskWithIdentifier: "UDAIR.Hotspot.login", using: DispatchQueue.global()) { task in
                self.handleBackgroundTask(task: task as! BGProcessingTask)
            }
        } else {
            // Check wifi connection once per minute
            UIApplication.shared.setMinimumBackgroundFetchInterval(10)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Perform connection attempt
        // Attempt will succeed (and attemptToConnect method will return true) if login is successful.
        // If the login page cannot be reached, either
        let loginHandler = LoginHandler()
        loginHandler.attemptToConnect() { success in
            if success {
                completionHandler(.newData)
            } else {
                completionHandler(.noData)
            }
        }
    }
    
    @available(iOS 13.0, *)
    func scheduleLoginTask() {
        let request = BGProcessingTaskRequest(identifier: "UDAIR.Hotspot.login")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 5)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print(error)
        }
    }
    
    @available(iOS 13.0, *)
    func handleBackgroundTask(task: BGProcessingTask) {
        let operationQueue = OperationQueue()
        scheduleLoginTask()
        
        let operation = LoginOperation()
        
        task.expirationHandler = {
            operation.cancel()
        }
        
        operation.completionBlock = {
            task.setTaskCompleted(success: !operation.isCancelled)
        }
        
        operationQueue.addOperation(operation)
    }


}


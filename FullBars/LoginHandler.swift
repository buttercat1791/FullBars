//
//  LoginHandler.swift
//  FullBars
//
//  Created by Michael Jurkoic on 12/13/19.
//  Copyright © 2019 Michael Jurkoic. All rights reserved.
//

import BackgroundTasks
import Foundation
import UIKit
import KeychainSwift
import Reachability

class LoginHandler {
    
    // Captive login page for UDAIR-Hotspot network
    let loginPage = "http://udair2.udallas.edu/cgi-bin/login"
    
    let keychain = KeychainSwift()
    let reachability = try! Reachability()
    
    // This is known to work:
    // curl --data "user=mjurkoic&password=900878077&cmd-authenticate&Login=Log+In" -X POST http://udair2.udallas.edu/cgi-bin/login
    func attemptToConnect(completionHandler: @escaping (Bool, Bool, Bool) -> Void) {
        var success = false
        var alreadyOnWifi = false
        var keychainValues = false
        
        let username: String? = keychain.get("FullBarsUsername")
        let password: String? = keychain.get("FullBarsPassword")
        
        // If no keychain values have been entered, use that return value to let the user know.
        // TODO: Add better checking for existence of keys.
        if (username != "" && password != "") {
            keychainValues = true
        } else {
            keychainValues = false
            completionHandler(success, alreadyOnWifi, keychainValues)
        }
        
        // If there is already a wifi connection, there is no need to go through all the login shenanigans.
        if reachability.connection == .wifi {
            alreadyOnWifi = true
        }
        
        let loginURLString = "\(loginPage)"
        let loginURL = URL(string: loginURLString)!
        let loginRequestBody = "user=\(username ?? "")&password=\(password ?? "")&cmd-authenticate&Login=Log+In"
        
        var loginRequest = URLRequest(url: loginURL)
        
        loginRequest.httpMethod = "POST"
        loginRequest.httpBody = loginRequestBody.data(using: .utf8)
        loginRequest.timeoutInterval = 2.0
        
        print(loginRequest)
        
        let task = URLSession(configuration: .ephemeral).dataTask(with: loginRequest) { (data, response, error) in
            if error != nil {
                print(error ?? "No error")
                success = false
            } else {
                success = true
                print(data ?? "No data")
            }
            completionHandler(success, alreadyOnWifi, keychainValues)
        }
        task.resume()
    }
    
}

//
//  LoginHandler.swift
//  FullBars
//
//  Created by Michael Jurkoic on 12/13/19.
//  Copyright © 2019 Michael Jurkoic. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess
import Reachability

class LoginHandler {
    
    // Captive login page for UDAIR-Hotspot network
    let loginPage = "http://udair2.udallas.edu/cgi-bin/login"
    
    let keychain = Keychain()
    let reachability = try! Reachability()
    
    // This is known to work:
    // curl --data "user=mjurkoic&password=900878077&cmd-authenticate&Login=Log+In" -X POST http://udair2.udallas.edu/cgi-bin/login
    func attemptToConnect(completionHandler: @escaping (_ success: Bool) -> Void) {
        print("Attempting to connect")
        
        var success: Bool = false
        
        let username: String? = "mjurkoic"
        let password: String? = "900878077"
        
        // If there is already a wifi connection, there is no need to go through all the login shenanigans.
        if reachability.connection != .wifi {
            success = true
            print("On cellular")
        } else {
            let loginURLString = "\(loginPage)"
            let loginURL = URL(string: loginURLString)!
            let loginRequestBody = "user=\(username ?? "")&password=\(password ?? "")&cmd-authenticate&Login=Log+In"
            
            var loginRequest = URLRequest(url: loginURL)
            
            loginRequest.httpMethod = "POST"
            loginRequest.httpBody = loginRequestBody.data(using: .utf8)
//            loginRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            loginRequest.addValue("user=\(username ?? "")&password=\(password ?? "")&cmd-authenticate&Login=Log+In", forHTTPHeaderField: "data-binary")
            loginRequest.timeoutInterval = 5.0
            
            print(loginRequest)
            
            let task = URLSession(configuration: .ephemeral).dataTask(with: loginRequest) { (data, response, error) in
                if error != nil {
                    success = false
                    print(error ?? "No error")
                } else {
                    success = true
                    print(response ?? "No response")
                }
                completionHandler(success)
            }
            task.resume()
        }
    }
    
}

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
    func attemptToConnect() -> Bool {
        var success: Bool = false
        
        let username = keychain[loginPage]
        let password = keychain[username ?? ""]
        
        // If there is already a wifi connection, there is no need to go through all the login shenanigans.
        if reachability.connection != .wifi {
            success = true
        } else {
            let loginURLString = "\(loginPage)?user=\(username ?? "")&password=\(password ?? "")&cmd-authenticate&Login=Log+In"
            let loginURL = URL(string: loginURLString)!
            var loginRequest = URLRequest(url: loginURL)
            
            loginRequest.httpMethod = "POST"
            
            let task = URLSession(configuration: .ephemeral).dataTask(with: loginRequest) { (data, response, error) in
                if error != nil {
                    success = false
                    print(error ?? "No error")
                } else {
                    success = true
                }
            }
            task.resume()
        }
        
        return success
    }
    
}

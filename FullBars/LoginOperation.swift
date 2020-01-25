//
//  LoginOperation.swift
//  FullBars
//
//  Created by Michael Jurkoic on 12/18/19.
//  Copyright © 2019 Michael Jurkoic. All rights reserved.
//

import KeychainSwift
import UIKit

class LoginOperation: Operation {
    
    let keychain = KeychainSwift()
    let automaticSuccesses = "AutomaticSuccesses"
    
    override func main() {
        let loginHandler = LoginHandler()
        
        loginHandler.attemptToConnect() { (success, alreadyOnWifi, keychainValues) in
            if success == true && alreadyOnWifi == false {
                var automaticCount = Int(self.keychain.get(self.automaticSuccesses) ?? "0") ?? 0
                automaticCount += 1
                self.keychain.set(String(automaticCount), forKey: self.automaticSuccesses)
            }
            if alreadyOnWifi {
                print("Already on wifi")
            } else if !success {
                print("Login attempt failed")
            }
        }
    }
    
}

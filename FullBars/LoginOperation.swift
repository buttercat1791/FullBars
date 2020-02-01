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
    let logger = StatisticsLogger()
    
    override func main() {
        let loginHandler = LoginHandler()
        
        loginHandler.attemptToConnect() { (success, alreadyOnWifi, keychainValues) in
            // Log the attempt for statistics-keeping
            if success == true {
                self.logger.log(manual: false, success: true)
            } else if success == false {
                self.logger.log(manual: false, success: false)
            }
        }
    }
    
}

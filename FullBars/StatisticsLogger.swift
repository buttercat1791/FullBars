//
//  StatisticsLogger.swift
//  FullBars
//
//  Created by Michael Jurkoic on 1/31/20.
//  Copyright © 2020 Michael Jurkoic. All rights reserved.
//

import KeychainSwift
import Foundation
import UIKit

class StatisticsLogger {
    
    let keychain = KeychainSwift()
    
    private enum AttemptType: String {
        case automatic = "automatic"
        case automaticSuccess = "automaticSuccess"
        case manual = "manual"
        case manualSuccess = "manualSuccess"
    }
    
    // Returns 4-tuple containing the attempt type counts stored in the keychain in the same order as they appear in the AttemptType enum.
    public func getLogs() -> (String, String, String, String) {
        var logTuple = (automatic: "0", automaticSuccess: "0", manual: "0", manualSuccess: "0")
        
        logTuple.automatic = self.keychain.get(AttemptType.automatic.rawValue) ?? "0"
        logTuple.automaticSuccess = self.keychain.get(AttemptType.automaticSuccess.rawValue) ?? "0"
        logTuple.manual = self.keychain.get(AttemptType.manual.rawValue) ?? "0"
        logTuple.manualSuccess = self.keychain.get(AttemptType.manualSuccess.rawValue) ?? "0"
        
        return logTuple
    }
    
    // Call this function after any login attempt anywhere in the app.
    public func log(manual: Bool, success: Bool) {
        if success == true {
            if manual == true {
                updateLogCount(type: .manualSuccess)
            } else {
                updateLogCount(type: .automaticSuccess)
            }
        } else if success == false {
            if manual == true {
                updateLogCount(type: .manual)
            } else {
                updateLogCount(type: .automatic)
            }
        }
    }
    
    // Increases by 1 the count stored on the keychain of the given type of login attempt, and saves the new value over the old value on the keychain.
    private func updateLogCount(type: AttemptType) {
        var attemptCount: Int = Int(self.keychain.get(type.rawValue) ?? "0") ?? 0
        attemptCount += 1
        keychain.set(String(attemptCount), forKey: type.rawValue)
    }
}

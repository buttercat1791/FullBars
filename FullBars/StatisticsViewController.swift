//
//  StatisticsViewController.swift
//  FullBars
//
//  Created by Michael Jurkoic on 1/24/20.
//  Copyright © 2020 Michael Jurkoic. All rights reserved.
//

import KeychainSwift
import UIKit

class StatisticsViewController: UIViewController {
    
    let keychain = KeychainSwift()
    let manualSuccesses = "ManualSuccesses"
    let automaticSuccesses = "AutomaticSuccesses"
    
    @IBOutlet weak var manualNumberLabel: UILabel!
    @IBOutlet weak var manualPercentLabel: UILabel!
    @IBOutlet weak var automaticNumberLabel: UILabel!
    @IBOutlet weak var automaticPercentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let manualNumber = Int(keychain.get(manualSuccesses) ?? "0") ?? 0
        let automaticNumber = Int(keychain.get(automaticSuccesses) ?? "0") ?? 0
        
        manualNumberLabel.text = String(manualNumber)
        automaticNumberLabel.text = String(automaticNumber)
        
        let percentsTuple = getPercents(manual: manualNumber, automatic: automaticNumber)
        
        manualPercentLabel.text = "\(percentsTuple.0)%"
        automaticPercentLabel.text = "\(percentsTuple.1)%"
    }
    
    func getPercents(manual: Int, automatic: Int) -> (Int, Int) {
        let total = manual + automatic
        
        var manualPercent = 0
        var automaticPercent = 0
        
        if total > 0 {
            manualPercent = manual/total
            automaticPercent = automatic/total
        } else {
            manualPercent = manual
            automaticPercent = automatic
        }
        
        return (manualPercent, automaticPercent)
    }
    
}

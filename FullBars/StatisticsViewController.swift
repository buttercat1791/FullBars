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
    let logger = StatisticsLogger()
    
    @IBOutlet weak var manualSuccessLabel: UILabel!
    @IBOutlet weak var automaticSuccessLabel: UILabel!
    @IBOutlet weak var manualTotalLabel: UILabel!
    @IBOutlet weak var automaticTotalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let logTuple = logger.getLogs()
        
        automaticTotalLabel.text = logTuple.0
        automaticSuccessLabel.text = logTuple.1
        manualTotalLabel.text = logTuple.2
        manualSuccessLabel.text = logTuple.3
    }
    
}

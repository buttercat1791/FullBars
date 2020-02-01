//
//  ViewController.swift
//  FullBars
//
//  Created by Michael Jurkoic on 12/13/19.
//  Copyright © 2019 Michael Jurkoic. All rights reserved.
//

import KeychainSwift
import UIKit

class HomeViewController: UIViewController {
    
    let successAlert = UIAlertController(title: "UDAIR-Hotspot", message: "Login successful!", preferredStyle: .alert)
    let alreadyConnectedAlert = UIAlertController(title: "FullBars", message: "Already connected to wifi.", preferredStyle: .alert)
    let failureAlert = UIAlertController(title: "Error", message: "Failed to connect.", preferredStyle: .alert)
    let keychainAlert = UIAlertController(title: "Missing Credentials", message: "Please add login credentials.", preferredStyle: .alert)
    
    let keychain = KeychainSwift()
    let logger = StatisticsLogger()

    @IBOutlet weak var loginAddButton: UIButton!
    @IBOutlet weak var loginActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        alreadyConnectedAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        failureAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        keychainAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        
    }

    @IBAction func loginAddButtonTapped(_ sender: Any) {
        let loginAddView = storyboard?.instantiateViewController(withIdentifier: "LoginAddView") as! LoginAddViewController
        tabBarController?.present(loginAddView, animated: true, completion: nil)
    }
    
    @IBAction func loginActionButtonTapped(_ sender: Any) {
        let loginHandler = LoginHandler()
        loginHandler.attemptToConnect { (success, alreadyOnWifi, keychainValues) in
            if success {
                DispatchQueue.main.async {
                    self.present(self.successAlert, animated: true, completion: nil)
                }
            } else if !keychainValues {
                DispatchQueue.main.async {
                    self.present(self.keychainAlert, animated: true, completion: nil)
                }
            } else if alreadyOnWifi {
                DispatchQueue.main.async {
                    self.present(self.alreadyConnectedAlert, animated: true, completion: nil)
                }
            } else if !success {
                DispatchQueue.main.async {
                    self.present(self.failureAlert, animated: true, completion: nil)
                }
            }
            
            // Log the attempt for statistics-keeping
            if success == true {
                self.logger.log(manual: true, success: true)
            } else if success == false {
                self.logger.log(manual: true, success: false)
            }
        }
    }
    
}


//
//  ViewController.swift
//  FullBars
//
//  Created by Michael Jurkoic on 12/13/19.
//  Copyright © 2019 Michael Jurkoic. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let successAlert = UIAlertController(title: "UDAIR-Hotspot", message: "Login successful!", preferredStyle: .alert)
    let alreadyConnectedAlert = UIAlertController(title: "FullBars", message: "Already connected to wifi.", preferredStyle: .alert)
    let failureAlert = UIAlertController(title: "Error", message: "Failed to connect.", preferredStyle: .alert)
    let keychainAlert = UIAlertController(title: "Missing Credentials", message: "Please add login credentials.", preferredStyle: .alert)

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
                self.present(self.successAlert, animated: true, completion: nil)
            } else if !keychainValues {
                self.present(self.keychainAlert, animated: true, completion: nil)
            } else if alreadyOnWifi {
                self.present(self.alreadyConnectedAlert, animated: true, completion: nil)
            } else if !success {
                self.present(self.failureAlert, animated: true, completion: nil)
            }
        }
    }
    
}


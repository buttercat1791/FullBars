//
//  LoginAddViewController.swift
//  FullBars
//
//  Created by Michael Jurkoic on 12/15/19.
//  Copyright © 2019 Michael Jurkoic. All rights reserved.
//

import UIKit
import KeychainAccess

class LoginAddViewController: UIViewController {
    
    // This must be the same as the one in LoginHandler.swift
    let loginPage = "http://udair2.udallas.edu/cgi-bin/login"
    
    var username = ""
    var password = ""
    
    var usernameEntered = false
    var passwordEntered = false
    
    @IBOutlet weak var loginAddButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TODO: Add better protection against bad input
    @IBAction func usernameFieldEditingDidEnd(_ sender: Any) {
        username = usernameField.text ?? ""
        usernameEntered = true
    }
    
    // TODO: Add better protection against bad input
    @IBAction func passwordFieldEditingDidEnd(_ sender: Any) {
        password = passwordField.text ?? ""
        passwordEntered = true
    }
    
    @IBAction func loginAddButtonTapped(_ sender: Any) {
        if usernameEntered && passwordEntered {
            // Save the entered credentials to a keychain for the login handler to use.
            let keychain = Keychain(server: loginPage, protocolType: .http)
            // So we can find the appropriate username later
            keychain[loginPage] = username
            keychain[username] = password
        }
        dismiss(animated: true, completion: nil)
    }
    
}

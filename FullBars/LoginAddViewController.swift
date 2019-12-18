//
//  LoginAddViewController.swift
//  FullBars
//
//  Created by Michael Jurkoic on 12/15/19.
//  Copyright © 2019 Michael Jurkoic. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginAddViewController: UIViewController {
    
    // This must be the same as the one in LoginHandler.swift
    let loginPage = "http://udair2.udallas.edu/cgi-bin/login"
    
    var username = ""
    var password = ""
    
    var usernameEntered = false
    var passwordEntered = false
    
    let keychain = KeychainSwift()
    
    @IBOutlet weak var loginAddButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
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
            keychain.set(username, forKey: "FullBarsUsername")
            keychain.set(password, forKey: "FullBarsPassword")
        }
        dismiss(animated: true, completion: nil)
    }
    
}

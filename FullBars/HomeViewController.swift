//
//  ViewController.swift
//  FullBars
//
//  Created by Michael Jurkoic on 12/13/19.
//  Copyright © 2019 Michael Jurkoic. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var loginAddButton: UIButton!
    @IBOutlet weak var loginActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginAddButtonTapped(_ sender: Any) {
        let loginAddView = storyboard?.instantiateViewController(withIdentifier: "LoginAddView") as! LoginAddViewController
        tabBarController?.present(loginAddView, animated: true, completion: nil)
    }
    
    @IBAction func loginActionButtonTapped(_ sender: Any) {
        let loginHandler = LoginHandler()
        loginHandler.attemptToConnect { success in
            if !success {
                print("Login failed")
            }
        }
    }
    
}


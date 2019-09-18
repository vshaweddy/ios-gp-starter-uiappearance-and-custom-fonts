//
//  SignupViewController.swift
//  UIAppearanceAndAnimation
//
//  Created by Spencer Curtis on 8/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppereance()

        guard AuthenticationHelper.currentUser != nil else { return }
        
        performSegue(withIdentifier: "ViewMessageList", sender: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let username = usernameTextField.text else { return }
        
        AuthenticationHelper.setCurrentUser(to: username)
        
        performSegue(withIdentifier: "ViewMessageList", sender: nil)
    }
    
    private func setupAppereance() {
        view.backgroundColor = AppearanceHelper.backgroundGray
        usernameTextField.font = AppearanceHelper.typerighterFont(with: .callout, pointSize: 28)
        AppearanceHelper.style(button: signupButton)
    }
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
}

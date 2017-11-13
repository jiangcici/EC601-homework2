//
//  Login.swift
//  FoodTracker
//
//  Created by Jiang on 10/8/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Login: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var DescLabel: UILabel!
    
    var isSignIn:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInSelectorChange(_ sender: UISegmentedControl) {
        // Flip the boolean
        isSignIn = !isSignIn
        
        // Check the bool and set the button and labels
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
            DescLabel.text = "Please enter your Email and Password"
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
            DescLabel.text = "Please create an account. Thank You!"
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        // Do some form validation on the email and password
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            // Check if it's sign in or register
            if isSignIn {
                // Sign in the user with Firebase
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    
                    // Check that user isn't nil
                    if let u = user {
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // Error: check error and show message
                        self.DescLabel.text = "Try Again."
                    }
                })
            }
            else {
                // Register the user with Firebase
                
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                    
                    // Check that user isn't nil
                    if let u = user {
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // Error: check error and show message
                        self.DescLabel.text = "Try Again."
                    }
                })
            }
            
        }
        

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

}

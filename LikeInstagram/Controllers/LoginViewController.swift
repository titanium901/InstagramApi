//
//  ViewController.swift
//  InstagramApi
//
//  Created by Yury Popov on 31.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet var usernameTextField: UITextField! {
        didSet {
            usernameTextField.tintColor = UIColor.lightGray
            usernameTextField.setIcon(UIImage(named: "man")!)
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            passwordTextField.tintColor = UIColor.lightGray
            passwordTextField.setIcon(UIImage(named: "key")!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: IBAction
    @IBAction func logInAction(_ sender: UIButton) {
        loginFireBase()
    }
    
    
    @IBAction func signUpAction(_ sender: UIButton) {
        registerInFireBase()
    }
    
    //MARK: Own Methods
    func setupUI() {
        logInButton.layer.cornerRadius = 10
        logInButton.layer.borderColor = UIColor.white.cgColor
        usernameTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
    }
    
    func registerInFireBase() {
        let alert = UIAlertController(title: "Register", message: "Check in", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            //Получили email и пароль, теперь можем создать пользователя Firebase
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (result, error) in
                if error != nil {
                    if let errorCode = AuthErrorCode(rawValue: error!._code) {
                        switch errorCode {
                        case .weakPassword:
                            print("Enter a more complex password!")
                        default:
                            print("Error")
                        }
                    }
                    return
                }
                if result != nil {
                    result?.user.sendEmailVerification(completion: { (error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            
                        }
                    })
                }
                
            })
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func loginFireBase() {
        print("Action")
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                self.errorLoginAlert(error: error.localizedDescription)
                return
            }
            if result != nil {
                self.performSegue(withIdentifier: "loginSeque", sender: nil)
            } else {
                return
            }
        }
    }
    
    func errorLoginAlert(error: String) {
        let ac = UIAlertController(title: "Oops...", message: error, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
        ac.addAction(okBtn)
        present(ac, animated: true)
    }
}

//MARK: extension UITextField

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 30, height: 30))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 40, height: 40))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}

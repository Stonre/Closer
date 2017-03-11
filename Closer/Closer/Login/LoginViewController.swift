//
//  LoginViewController.swift
//  Closer
//
//  Created by Kami on 2016/12/25.
//  Copyright © 2016年 Kami. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let loginRegisterSegmentedControl = UISegmentedControl(items: ["登录", "注册"])
    var loginRegisterButton = UIButton()
    let containerView = UIView()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    
    var containerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupViews() {
        setupLogoImageView()
        setupLoginRegisterSegmentedControl()
        setupInputTextFields()
        setupLoginRegisterButton()
    }
    
    private func setupLogoImageView() {
        logoImageView.backgroundColor = UIColor(white: 1, alpha: 0)
        logoImageView.image = #imageLiteral(resourceName: "sampleHeaderPortrait5")
        logoImageView.layer.cornerRadius = 20
        logoImageView.clipsToBounds = true
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.16).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.tintColor = .white
        loginRegisterSegmentedControl.selectedSegmentIndex = 0
        loginRegisterSegmentedControl.addTarget(self, action: #selector(switchLoginRegister), for: .valueChanged)
        
        view.addSubview(loginRegisterSegmentedControl)
        loginRegisterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        loginRegisterSegmentedControl.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30).isActive = true
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30)
        
    }
    
    func switchLoginRegister() {
        view.endEditing(true)
        nameTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor?.isActive = false
        loginRegisterButton.setTitle(loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex), for: .normal)


        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            containerViewHeightAnchor?.constant = 100
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.0)
//            nameTextField.placeholder = ""
//            nameTextField.text = nil
            nameTextField.isHidden = true
            
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5)
            
            passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5)
            
        } else if loginRegisterSegmentedControl.selectedSegmentIndex == 1 {
            containerViewHeightAnchor?.constant = 150
            containerView.addSubview(nameTextField)
            nameTextField.isHidden = false
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3)
            nameTextField.placeholder = "姓名"
            
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3)
            
            passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3)
        }
        
        nameTextFieldHeightAnchor?.isActive = true
        emailTextFieldHeightAnchor?.isActive = true
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    private func setupInputTextFields() {
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.bottomAnchor, constant: 12).isActive = true
        
        containerViewHeightAnchor = containerView.heightAnchor.constraint(equalToConstant: 100)
        containerViewHeightAnchor?.isActive = true
        
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
    }
    
    private func setupNameTextField() {
        nameTextField.placeholder = ""
        nameTextField.isHidden = true
        nameTextField.delegate = self
        containerView.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -10).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0)
        nameTextFieldHeightAnchor?.isActive = true
    }
    
    private func setupEmailTextField() {
        emailTextField.placeholder = "电子邮件"
        emailTextField.delegate = self
        emailTextField.autocapitalizationType = .none
        if let lastEmail = UserDefaults.standard.value(forKey: "userEmail") as? String {
            emailTextField.text = lastEmail
        }
        containerView.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -10).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/2)
        emailTextFieldHeightAnchor?.isActive = true
    }
    
    private func setupPasswordTextField() {
        passwordTextField.placeholder = "密码"
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.becomeFirstResponder()
        containerView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -10).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/2)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    private func setupLoginRegisterButton() {
        loginRegisterButton = UIButton(type: UIButtonType.system)
        loginRegisterButton.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1.0)
        loginRegisterButton.addTarget(self, action: #selector(touchLoginRegister(_:)), for: .touchUpInside)
        let currTitle = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(currTitle, for: .normal)
        loginRegisterButton.setTitleColor(.white, for: .normal)
        view.addSubview(loginRegisterButton)
        loginRegisterButton.translatesAutoresizingMaskIntoConstraints = false
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 30).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: 0).isActive = true
    }
    
    func touchLoginRegister(_ sender: UIButton) {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else if loginRegisterSegmentedControl.selectedSegmentIndex == 1 {
            handleRegister()
        }
    }
    
    private func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text
            else {
                print("guard failure")
                return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: { (error) in
                if error  != nil {
                    print(error!)
                }
            })
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let currUserID = FIRAuth.auth()?.currentUser?.uid {
                    if !self.setDisplayName(name) {
                        print("Set new user display name failed!")
                    }
                    let ref = FIRDatabase.database().reference()
//                    let key = ref.child("users").childByAutoId().key
                    let user = ["email": email,
                                "name": name]
                    ref.updateChildValues(["users/\(currUserID)": user])
                    
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(email, forKey: "userEmail")
                    
                    self.present(DCViewController(), animated: true, completion: nil)
                }
            })
        }
    }
    
    func setDisplayName(_ name: String) -> Bool {
        var result = false
        if let currUser = FIRAuth.auth()?.currentUser {
            let nameRequest = currUser.profileChangeRequest()
            nameRequest.displayName = name
            nameRequest.commitChanges() { (error) in
                if error != nil {
                    print("Set display name error %@", error!)
                    return
                }
                result = true
            }
        } else {
            print("No current user")
        }
        return result
    }
    
    private func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text
            else {
                return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            
            let userDefault = UserDefaults.standard
            userDefault.setValue(email, forKey: "userEmail")
            
            self.present(DCViewController(), animated: true, completion: nil)

        
        })

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        touchLoginRegister(loginRegisterButton)
        return false
    }
}

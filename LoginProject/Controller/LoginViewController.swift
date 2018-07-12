//
//  LoginViewController.swift
//  LoginProject
//
//  Created by seob on 2018. 7. 2..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController { 
    var ref: DatabaseReference!
    
        let logoImageView: UIImageView = {
            let view = UIImageView()
            let image = UIImage(named: "FastCampus_Logo-2")
            view.image = image
            view.contentMode = .scaleAspectFit
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let inputBoxView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 5
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let inputSeparatorView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let useridTextField: UITextField = {
            let tf = UITextField()
            tf.placeholder = "이메일"
            tf.textColor = .black
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()
        
        let pwdTextField: UITextField = {
            let tf = UITextField()
            tf.placeholder = "비밀번호 (4~32자)"
            tf.textColor = .black
            tf.isSecureTextEntry = true
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()
        
        let loginButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor =  #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
            button.setTitle("로그인", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            
            button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
            return button
        }()
        
        let registButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
            button.setTitle("회원가입", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            
            button.addTarget(self, action: #selector(registAction), for: .touchUpInside)
            return button
        }()
    
        let bgImageView: UIImageView = {
           let view = UIImageView()
            view.image = UIImage(named: "channelBgImage")
            view.contentMode = .scaleAspectFit
            view.isUserInteractionEnabled = true
            return view
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            bgImageView.frame = view.frame
            view.addSubview(bgImageView)
            useridTextField.delegate = self
            pwdTextField.delegate = self
            
            bgImageView.addSubview(logoImageView)
            bgImageView.addSubview(inputBoxView)
            bgImageView.addSubview(loginButton)
            bgImageView.addSubview(registButton)
            
            setupImageView()
            setupInputBoxView()
            setupLoginButton()
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillShow(_:)),
                name: .UIKeyboardWillShow,
                object: nil)
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillHide(_:)),
                name: .UIKeyboardWillHide,
                object: nil)
            
    }
        
        func setupImageView(){
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            logoImageView.bottomAnchor.constraint(equalTo: inputBoxView.topAnchor , constant: -30).isActive = true
            logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
        }
        
        func setupInputBoxView(){
            inputBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            inputBoxView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            inputBoxView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
            inputBoxView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
            inputBoxView.addSubview(useridTextField)
            inputBoxView.addSubview(inputSeparatorView)
            inputBoxView.addSubview(pwdTextField)
            
            useridTextField.leadingAnchor.constraint(equalTo: inputBoxView.leadingAnchor, constant: 12).isActive = true
            useridTextField.topAnchor.constraint(equalTo: inputBoxView.topAnchor).isActive = true
            useridTextField.widthAnchor.constraint(equalTo: inputBoxView.widthAnchor).isActive = true
            useridTextField.heightAnchor.constraint(equalTo: inputBoxView.heightAnchor, multiplier : 1/2).isActive = true
            
            inputSeparatorView.leadingAnchor.constraint(equalTo: inputBoxView.leadingAnchor).isActive = true
            inputSeparatorView.topAnchor.constraint(equalTo: useridTextField.bottomAnchor).isActive = true
            inputSeparatorView.widthAnchor.constraint(equalTo: inputBoxView.widthAnchor).isActive = true
            inputSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            pwdTextField.leadingAnchor.constraint(equalTo: inputBoxView.leadingAnchor, constant: 12).isActive = true
            pwdTextField.topAnchor.constraint(equalTo: inputSeparatorView.bottomAnchor).isActive = true
            pwdTextField.widthAnchor.constraint(equalTo: inputBoxView.widthAnchor).isActive = true
            pwdTextField.heightAnchor.constraint(equalTo: inputBoxView.heightAnchor, multiplier : 1/2).isActive = true
            
        }
        
        func setupLoginButton(){
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            loginButton.topAnchor.constraint(equalTo: inputBoxView.bottomAnchor, constant: 30).isActive = true
            loginButton.widthAnchor.constraint(equalTo: inputBoxView.widthAnchor).isActive = true
            loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            registButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            registButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
            registButton.widthAnchor.constraint(equalTo: inputBoxView.widthAnchor).isActive = true
            registButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        }
    
    // MARK: - loginButtonAction
        @objc func loginAction(){
            self.ref = Database.database().reference()
            if let userid = useridTextField.text {
                if userid.isEmpty {
                    let alert = UIAlertController(title: "아이디", message: "아이디를 입력해주세요", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(ok)
                    present(alert, animated: true, completion: nil)
                    
                }
            }
            
            if let userpwd = pwdTextField.text {
                if userpwd.isEmpty {
                    let alert = UIAlertController(title: "패스워드", message: "패스워드를 입력해주세요", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(ok)
                    present(alert, animated: true, completion: nil)
                }
            }
            
            guard let userid = useridTextField.text ,
                let userpwd = pwdTextField.text else { return }
            
            Auth.auth().signIn(withEmail: userid, password: userpwd) { (user, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "아이디 혹시 패스워드가 일치하지않습니다.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }else{ 
                    let viewVC = UINavigationController(rootViewController: ViewController())
                    self.present(viewVC, animated: true, completion: nil)
                }
            }
        }
    // MARK: - registButtonAction
        @objc func registAction(){
            let registVC = UINavigationController(rootViewController: RegisterViewController())
             present(registVC, animated: true, completion: nil)
        }
    
    //화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
     
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -100 // Move view 150 points upward
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
 }


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}







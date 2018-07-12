//
//  RegisterViewController.swift
//  LoginProject
//
//  Created by seob on 2018. 7. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
    var ref: DatabaseReference!
    
    let inputContainerView: UIView =  {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
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
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "이름"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "이메일"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor =  #colorLiteral(red: 0.897992228, green: 0.897992228, blue: 0.897992228, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호(4~31자)"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var profileView: UIImageView = {
        let view = UIImageView()
        let img = UIImage(named: "PlaceHolder")
        view.image = img
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelProfileImageView)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        navigationItem.title = "회원가입"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handelBack))
        
        bgImageView.addSubview(profileView)
        bgImageView.addSubview(inputContainerView)
        bgImageView.addSubview(registButton)
        
        setupProfile()
        setupContainerView()
        setupRegistButton()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
    
    
    func setupProfile(){
        profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor , constant: -30).isActive = true
        profileView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupContainerView(){
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeparatorView)
        inputContainerView.addSubview(passwordTextField)
        
        nameTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier : 1/3).isActive = true
        
        nameSeparatorView.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier : 1/3).isActive = true
        
        nameSeparatorView.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        passwordTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier : 1/3).isActive = true 
        
    }
    
    func setupRegistButton(){
        registButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        registButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        registButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}


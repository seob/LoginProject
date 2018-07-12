//
//  Register.handel.swift
//  LoginProject
//
//  Created by seob on 2018. 7. 3..
//  Copyright © 2018년 seob. All rights reserved.
//
 
import UIKit
import Firebase

extension RegisterViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    // MARK: - registAction
    @objc func registAction(){
        if let username = nameTextField.text {
            if username.isEmpty {
                let alert = UIAlertController(title: "알림", message: "이름을 입력해주세요", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
                
            }
        }
        
        if let useremail = emailTextField.text {
            if useremail.isEmpty {
                let alert = UIAlertController(title: "알림", message: "이메일을 입력해주세요", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
                
            }
        }
        
        if let userpwd = passwordTextField.text {
            if userpwd.isEmpty {
                let alert = UIAlertController(title: "알림", message: "패스워드를 입력해주세요", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
        }
        
        guard  let userid = emailTextField.text ,
            let userpwd = passwordTextField.text,
            let userNmae = nameTextField.text,
            let userImage = profileView.image  else { return }
        
        Auth.auth().createUser(withEmail: userid, password: userpwd) { (user, error) in
             
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("\(imageName).png")
            if let uploadData = UIImagePNGRepresentation(userImage) {
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                     if let profileUrl = metadata?.downloadURL()?.absoluteString {
                        let values = ["user_name" : userNmae ,"userid" : userid , "userpwd" : userpwd ,"user_profile" : profileUrl]
                        self.registUserInfoData(uid: uid, value: values as [String : AnyObject])
                    }
                })
            }
        }
    }
    // MARK: = registUserInfoData (회원정보를 받아서 디비에 저장)
    func registUserInfoData(uid: String , value: [String:AnyObject]){
        self.ref = Database.database().reference()
        let usersReference = self.ref.child("tbl_user").child(uid)
         usersReference.updateChildValues(value, withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            self.dismiss(animated: true)
        })
    }
    
    // MARK: - handelBack (뒤로가기 버튼을 눌렀을때)
    @objc func handelBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - handelProfileImageView (프로파일 이미지를 눌렀을때 호출)
    @objc func handelProfileImageView(){
        let picter = UIImagePickerController()
        picter.delegate = self
        picter.allowsEditing = true
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        picter.sourceType = .photoLibrary
         
        present(picter, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        let editImage = info[UIImagePickerControllerEditedImage] as? UIImage
        let selectedImage = editImage ?? originImage
        
        profileView.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}

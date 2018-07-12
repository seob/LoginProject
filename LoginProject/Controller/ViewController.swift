//
//  ViewController.swift
//  LoginProject
//
//  Created by seob on 2018. 7. 6..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let callId = "callid"
    var userInfoData =  [User]()
    let tableView: UITableView = {
       let tableview = UITableView()
        return tableview
    }()
    /*test*/
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handelLogout))
        loginCheck()
        fetchUser()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: callId)
        view.addSubview(tableView)
    }
 
    func fetchUser(){
       let ref = Database.database().reference().child("tbl_user")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if  let dic = snapshot.value as? [String: AnyObject] {
                for index in dic {
                    let user = User()
                     user.name = index.value["user_name"] as? String
                    user.email = index.value["userid"] as? String
                    user.profile = index.value["user_profile"] as? NSURL
                    self.userInfoData.append(user)
                    DispatchQueue.global().async {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            print("end dispatch")
                        }
                    }
                    dump(self.userInfoData)
                }
            }
        })
 
    }
    // MARK: - loginCheck 로그인 되어있는지 체크
    func loginCheck() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handelLogout), with: nil, afterDelay: 0)
        }else{
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("tbl_user").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["user_name"] as? String
                    
                }
            }
        }
    }

    // MARK: - handelLogout
    @objc func handelLogout(){
        do {
            try Auth.auth().signOut()
            let loginController = LoginViewController()
            present(loginController, animated: true, completion: nil)
        }
        catch {
            print(error)
            print("error: there was a problem logging out")
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return userInfoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: callId, for: indexPath) as! UserCell
     
        cell.textLabel?.text = userInfoData[indexPath.row].name
        cell.detailTextLabel?.text = userInfoData[indexPath.row].email
        cell.imageView?.image = UIImage(named: "floatBgImage")
        
        if let userProfileUser = userInfoData[indexPath.row].profile {
            let url = NSURL(string: userProfileUser)
        
        }
         return cell
    }
}

final class UserCell: UITableViewCell {
    let profileView: UIImageView = {
        let view =  UIImageView()
        view.image = UIImage(named: "floatBgImage")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        profileView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        textLabel?.frame = CGRect(x: 56, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 56, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  ChatLogCollectionViewController.swift
//  LoginProject
//
//  Created by seob on 2018. 7. 6..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChatLogCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setupInputView()
 
    }
    func setupInputView(){
        let inputBox = UIView()
        inputBox.backgroundColor = .red
        inputBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputBox)
        
        inputBox.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        inputBox.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        inputBox.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        inputBox.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

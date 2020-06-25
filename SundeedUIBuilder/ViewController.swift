//
//  ViewController.swift
//  SundeedUI
//
//  Created by Nour Sandid on 6/23/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let scrollView: UIScrollView = UIScrollView()
    let logoImageView: UIImageView = UIImageView()
    let loginButton: UIButton = UIButton()
    let credentialsView: UIView = UIView()
    let usernameTextField: UITextField = UITextField()
    let passwordTextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.image = UIImage(named: "logo")
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemGreen
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        [usernameTextField, passwordTextField].forEach{$0.borderStyle = .line}
        SundeedUIBuilder(view).add(scrollView)
            .fill()
            .except(.bottom)
            .except(.top)
            .alignTop()
            .withPadding(74)
        
        SundeedUIBuilder(scrollView).add(logoImageView)
            .alignTop()
            .withHeight(equalTo: 200)
            .alignTrailing()
            .alignLeading()
            .withMaximumWidth(450)
            .centerHorizontally()
        
        SundeedUIBuilder(view).add(loginButton)
            .under(scrollView)
            .alignLeading().withPadding(16)
            .alignTrailing().withPadding(16)
            .alignBottom().withPadding(64)
            .withHeight(equalTo: 64)
        
        SundeedUIBuilder(scrollView).add(credentialsView)
            .alignLeading().withPadding(16)
            .alignTrailing().withPadding(16)
            .withWidth(of: view).withPadding(-32).orAtleastTry()
            .withMaximumWidth(950)
            .centerHorizontally()
            .under(logoImageView).withPadding(64)
            .alignBottom().withPadding(32)
        
        SundeedUIBuilder(credentialsView).add(usernameTextField)
            .alignLeading().withPadding(8)
            .alignTrailing().withPadding(8)
            .withHeight(equalTo: 74)
            .alignTop().withPadding(8)
        
        SundeedUIBuilder(credentialsView).add(passwordTextField)
            .alignLeading().withPadding(8)
            .alignTrailing().withPadding(8)
            .under(usernameTextField).withPadding(32)
            .withHeight(equalTo: 74)
            .alignBottom()
            .withHeight(equalTo: .height, of: usernameTextField)
    }
}


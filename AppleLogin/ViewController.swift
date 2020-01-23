//
//  ViewController.swift
//  AppleLogin
//
//  Created by Pitchaorn on 22/1/2563 BE.
//  Copyright © 2563 Freewillsolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @available(iOS 13.0, *)
    lazy var appleButton: AppleButton = {
        [unowned self] in
        let button = AppleButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        button.delegate = self
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if #available(iOS 13.0, *) {
            appleButton.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(appleButton)
            
            NSLayoutConstraint.activate([
                appleButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1),
                appleButton.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 1),
                appleButton.heightAnchor.constraint(equalToConstant: 40),
                appleButton.widthAnchor.constraint(equalToConstant: 200)
            ])
        }
        
    }


}
@available(iOS 13.0, *)
extension ViewController:AppleButtonDelegate{
    func loginButton(_ button: AppleButton, didSucceedLogin token: String) {
        print(token)
    }
    
    func loginButton(_ button: AppleButton, didFailLogin error: Error) {
        
    }
    
    
}

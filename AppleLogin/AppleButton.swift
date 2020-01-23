//
//  AppleButton.swift
//  AppleLogin
//
//  Created by Pitchaorn on 22/1/2563 BE.
//  Copyright © 2563 Freewillsolutions. All rights reserved.
//

import UIKit
import AuthenticationServices

@available(iOS 13.0, *)
public protocol AppleButtonDelegate: class {
    
    
    /// Called if the login action succeeded.
    ///
    /// - Parameters:
    ///   - button: The button which is used to start the login action.
    ///   - Token: The successful login result.
    func loginButton(_ button: AppleButton, didSucceedLogin token: String)
    
    /// Called if the login action failed.
    ///
    /// - Parameters:
    ///   - button: The button which is used to start the login action.
    ///   - error: The error of the failed login.
    func loginButton(_ button: AppleButton, didFailLogin error: Error)
    
}
@available(iOS 13.0, *)
open class AppleButton: ASAuthorizationAppleIDButton {
    
    public weak var delegate: AppleButtonDelegate?
    
    /// Determines the view controller that presents the login view controller. If the value is `nil`, the most
    /// top view controller in the current view controller hierarchy will be used.
    public weak var presentingViewController: UIViewController?
    
    public override init(authorizationButtonType type: ASAuthorizationAppleIDButton.ButtonType, authorizationButtonStyle style: ASAuthorizationAppleIDButton.Style) {
        super.init(authorizationButtonType: type, authorizationButtonStyle: style)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Setup the default style of `LoginButton`.
    func setup() {
        
        addTarget(self, action:#selector(login), for: .touchUpInside)
    }
    
    // Executes the login action when the user taps the login button.
    @objc open func login() {
        let authorizationProvider = ASAuthorizationAppleIDProvider()
        let request = authorizationProvider.createRequest()
        request.requestedScopes = [.email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}

@available(iOS 13.0, *)
extension AppleButton:ASAuthorizationControllerDelegate{
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        
        print("AppleID Crendential Authorization: userId: \(appleIDCredential.user), email: \(String(describing: appleIDCredential.email))")
        UserDefaults.standard.set(appleIDCredential.user, forKey: "userIdentifier")
        guard let identityToken = appleIDCredential.identityToken, let token =  String(data: identityToken, encoding: .utf8) else { return  }
        delegate?.loginButton(self, didSucceedLogin: token)
        
    }
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("AppleID Crendential failed with error: \(error.localizedDescription)")
        self.delegate?.loginButton(self, didFailLogin: error)
    }
}
@available(iOS 13.0, *)
extension AppleButton:ASAuthorizationControllerPresentationContextProviding{
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window :UIWindow = UIApplication.shared.keyWindow else { return UIWindow() }
        return window
    }
    
    
}


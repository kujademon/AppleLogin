//
//  AppDelegate.swift
//  AppleLogin
//
//  Created by Pitchaorn on 22/1/2563 BE.
//  Copyright © 2563 Freewillsolutions. All rights reserved.
//

import UIKit
import AuthenticationServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    
    @available(iOS 13.0, *)
    func checkAuth(){
        guard let userIdentifier = UserDefaults.standard.string(forKey: "userIdentifier") else {return}
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid. Show Home UI Here
                break
            case .revoked:
                // The Apple ID credential is revoked. Show SignIn UI Here.
                break
            case .notFound:
                // No credential was found. Show SignIn UI Here.
                break
            default:
                break
            }
        }
    }

}


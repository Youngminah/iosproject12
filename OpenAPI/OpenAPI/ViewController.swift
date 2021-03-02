//
//  ViewController.swift
//  OpenAPI
//
//  Created by meng on 2021/03/02.
//


// Swift // // Add this to the header of your file, e.g. in ViewController.swift

import FBSDKLoginKit

class ViewController: UIViewController , LoginButtonDelegate
{

    @IBOutlet weak var loginButton: FBLoginButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completionHandler: {connection, result, error in
                            print("\(result)")
                
            })
        }
        else{
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
        }
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completionHandler: {connection, result, error in
                        print("\(result)")
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
}



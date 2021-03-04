//
//  ViewController.swift
//  OpenAPI
//
//  Created by meng on 2021/03/02.
//


import FBSDKLoginKit

class ViewController: UIViewController , LoginButtonDelegate
{

    @IBOutlet weak var loginButton: FBLoginButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        if let token = AccessToken.current,!token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completionHandler: {connection, result, error in
                print("\(result)")
                guard error == nil else { return }
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let nextView = mainStoryboard.instantiateViewController(identifier: "TabBarController")
                self.navigationController?.pushViewController(nextView, animated: true)
            })
            print("login")
        }
        else{
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            print("notlogin")
            //화면 전환
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
            guard error == nil else { return }
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let nextView = mainStoryboard.instantiateViewController(identifier: "TabBarController")
            self.navigationController?.pushViewController(nextView, animated: true)
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
}



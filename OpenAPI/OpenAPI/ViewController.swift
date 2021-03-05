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
        NotificationCenter.default.addObserver(self, selector: #selector(logoutAction), name: Notification.Name("logoutButtonClicked"), object: nil)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                nextView.modalPresentationStyle = .fullScreen
                self.present(nextView, animated: true, completion: nil)
            })
            print("login")
        }
        else{
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            print("notlogin")
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
            print("loginbutton")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let nextView = mainStoryboard.instantiateViewController(identifier: "TabBarController")
            nextView.modalPresentationStyle = .fullScreen
            self.present(nextView, animated: true, completion: nil)
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    @objc func logoutAction(){
        let manager = LoginManager()
        manager.logOut()
        let cookies = HTTPCookieStorage.shared
    }
    
}



//
//  SceneDelegate.swift
//  LifeCycle
//
//  Created by meng on 2021/02/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let simplePlayer = Player.shared
    var restart: Bool = false

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("sceneDidDisconnect")
        UserDefaults.standard.set(simplePlayer.like, forKey: "like")
    }

    //active함수는 홈으로 나가지 않고 화면만 줄여도 실행되는생명주기.
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("sceneDidBecomeActive")
        if (restart){
            simplePlayer.play()
        }else{
            simplePlayer.pause()
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("sceneWillResignActive")
        if(simplePlayer.isPlaying){
            restart = true
            simplePlayer.pause()
        }else{
            restart = false
        }
    }

    //이곳에 이어재생을 넣으니 처음 시작할때도 뜸.
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("sceneWillEnterForeground")
        simplePlayer.like = UserDefaults.standard.integer(forKey: "like")

    }

    //이곳에 이어재생 메세지를 넣으니 앱에서 홈으로 잠깐 나갓다 왔을때 뜸.
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("sceneDidEnterBackground")
        let alert = UIAlertController(title: nil, message:"음악을 이어 재생합니다", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}

